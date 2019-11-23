//
//  ValueCollectionViewCell.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class ValueCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        valueLabel.textColor = BelaTheme.shared.textColor2
    }
    
    func setup(for value: String) {
        valueLabel.text = value
    }
}
