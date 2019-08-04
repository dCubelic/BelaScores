//
//  DetectedCardsView.swift
//  BelaDetector
//
//  Created by dominik on 04/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class DetectedCardsView: UIView {

    @IBOutlet weak var trumpSuitButton: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var splitLineView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var belaCards: [BelaCard] = []
    private var trumpSuit: BelaSuit? {
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
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        splitLineView.layer.cornerRadius = splitLineView.frame.width / 2
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(UINib(nibName: "DetectedCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetectedCardCollectionViewCell")
    }
    
    func updatePoints() {
        guard let trumpSuit = trumpSuit else { return }
        
        var points = 0
        for card in belaCards {
            points += card.points(trumpSuit: trumpSuit)
        }
        
        DispatchQueue.main.async {
            self.pointsLabel.text = String(points)
        }
    }
    
    func set(trumpSuit: BelaSuit) {
        self.trumpSuit = trumpSuit
        trumpSuitButton.setImage(UIImage(named: trumpSuit.imageName), for: .normal)
    }
    
    func add(card: BelaCard) {
        belaCards.insert(card, at: 0)
        updatePoints()
        
        DispatchQueue.main.async {
            self.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
        }
    }
    
}

extension DetectedCardsView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//    }
}

extension DetectedCardsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return belaCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetectedCardCollectionViewCell", for: indexPath) as! DetectedCardCollectionViewCell
        
        cell.setup(for: belaCards[indexPath.row])
        cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        return cell
    }
    
}
