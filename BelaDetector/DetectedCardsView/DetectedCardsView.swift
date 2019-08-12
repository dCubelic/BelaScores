//
//  DetectedCardsView.swift
//  BelaDetector
//
//  Created by dominik on 04/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol DetectedCardsViewDelegate: class {
    func detectedCardsViewDidRequestTrumpSuitChange(_ detectedCardsView: DetectedCardsView)
    func detectedCardsViewDidRemoveCard(_ card: BelaCard)
}

class DetectedCardsView: UIView {

    @IBOutlet weak var trumpSuitImageView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var splitLineView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var points: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.pointsLabel.text = String(self.points)
            }
        }
    }
    
    weak var delegate: DetectedCardsViewDelegate?
    
    private var belaCards: [BelaCard] = []
    private var trumpSuit: BelaSuit? {
        didSet {
            updatePoints()
        }
    }
    var plusTen = false {
        didSet {
            updatePoints()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        _ = loadViewFromNib()
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        splitLineView.layer.cornerRadius = splitLineView.frame.width / 2
        
        let trumpSuitTapGesture = UITapGestureRecognizer(target: self, action: #selector(trumpSuitAction(_:)))
        trumpSuitImageView.addGestureRecognizer(trumpSuitTapGesture)
        trumpSuitImageView.isUserInteractionEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(UINib(nibName: "DetectedCardCollectionViewCell", bundle: Bundle.frameworkBundle), forCellWithReuseIdentifier: "DetectedCardCollectionViewCell")
    }
    
    func updatePoints() {
        guard let trumpSuit = trumpSuit else { return }
        
        var points = 0
        for card in belaCards {
            points += card.points(trumpSuit: trumpSuit)
        }
        
        points += plusTen ? 10 : 0
        
        self.points = points
    }
    
    func set(trumpSuit: BelaSuit) {
        self.trumpSuit = trumpSuit
        trumpSuitImageView.image = UIImage(named: trumpSuit.imageName)
    }
    
    func add(card: BelaCard) {
        
        DispatchQueue.main.async {
            self.belaCards.insert(card, at: 0)
            self.updatePoints()
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
            }, completion: { _ in
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
            })
        }
    }
    
    func reset() {
        plusTen = false
        belaCards = []
        updatePoints()
        collectionView.reloadData()
    }
    
    @IBAction func trumpSuitAction(_ sender: Any) {
        delegate?.detectedCardsViewDidRequestTrumpSuitChange(self)
    }
}

extension DetectedCardsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = NSString(string: belaCards[indexPath.row].value.string).size(withAttributes: nil).width + 60
        return CGSize(width: width, height: collectionView.frame.height)
    }
}

extension DetectedCardsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return belaCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: DetectedCardCollectionViewCell.self, for: indexPath)
        
        cell.setup(for: belaCards[indexPath.row])
        cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        return cell
    }
    
}

extension DetectedCardsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let index = self.belaCards.firstIndex(of: belaCards[indexPath.row]) else { return }
        
        DispatchQueue.main.async {
            
            self.delegate?.detectedCardsViewDidRemoveCard(self.belaCards[indexPath.row])
            self.belaCards.remove(at: index)
            self.updatePoints()
            
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [indexPath])
            }, completion: nil)
            
        }
    }
    
}
