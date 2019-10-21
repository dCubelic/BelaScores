//
//  ThemeCollectionViewCell.swift
//  BlokZaBelu
//
//  Created by dominik on 21/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var outerView: UIView!
    @IBOutlet weak private var innerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .clear
        
        outerView.layer.masksToBounds = true
        outerView.layer.cornerRadius = outerView.frame.height / 2
        innerView.layer.masksToBounds = true
        innerView.layer.cornerRadius = innerView.frame.height / 2
    }
    
    func setup(for theme: Theme) {
        outerView.backgroundColor = theme.themeColor
        innerView.backgroundColor = theme.backgroundColor
        
        if theme == BelaTheme.shared.theme {
            alpha = 1
        } else {
            alpha = 0.3
        }
    }

}
