//
//  DetectedCardCollectionViewCell.swift
//  BelaDetector
//
//  Created by dominik on 04/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class DetectedCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var suitImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setup(for card: BelaCard) {
        valueLabel.text = card.value.string
        suitImageView.image = UIImage(named: card.suit.imageName)
    }
}
