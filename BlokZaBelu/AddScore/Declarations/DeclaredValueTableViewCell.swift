//
//  DeclaredValueTableViewCell.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class DeclaredValueTableViewCell: UITableViewCell {

    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
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
        print("remove")
    }
}
