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

    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    weak var delegate: DeclaredValueTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        
        removeButton.layer.cornerRadius = removeButton.frame.height / 2
        removeButton.layer.masksToBounds = true
    }
    
    func setup(for points: Int) {
        pointsLabel.text = "+\(points)"
    }
    
    @IBAction func removeAction(_ sender: Any) {
        delegate?.declaredValueTableViewCellDidPressRemove(self)
    }
}
