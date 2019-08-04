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
    
    func set(trumpSuit: BelaSuit) {
        trumpSuitButton.setImage(UIImage(named: trumpSuit.imageName), for: .normal)
    }
    
    func set(points: Int) {
        pointsLabel.text = String(points)
    }
    
    func add(card: BelaCard) {
        belaCards.append(card)
//        collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
//        collectionView.reloadData()
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
