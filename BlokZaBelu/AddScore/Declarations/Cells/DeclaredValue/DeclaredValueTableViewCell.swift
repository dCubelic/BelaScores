//
//  DeclaredValueTableViewCell.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol DeclaredValueTableViewCellDelegate: class {
    func declaredValueTableViewCellDidPressRemove(_ declaredValueTableViewCell: DeclaredValueTableViewCell)
}

class DeclaredValueTableViewCell: UITableViewCell {

    @IBOutlet weak private var pointsLabel: UILabel!
    @IBOutlet weak private var removeButton: UIButton!
    
    weak var delegate: DeclaredValueTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        
        removeButton.layer.cornerRadius = removeButton.frame.height / 2
        removeButton.layer.masksToBounds = true
        removeButton.backgroundColor = BelaTheme.shared.transparentBackgroundColor
        
        pointsLabel.textColor = BelaTheme.shared.textColor
    }
    
    func setup(for points: Int) {
        pointsLabel.text = "+\(points)"
    }
    
    @IBAction private func removeAction(_ sender: Any) {
        delegate?.declaredValueTableViewCellDidPressRemove(self)
    }
}
