//
//  DeleteHistoryTableViewCell.swift
//  BlokZaBelu
//
//  Created by dominik on 27/01/2020.
//  Copyright © 2020 Dominik Cubelic. All rights reserved.
//

import UIKit

class DeleteHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak private var label: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        
        label.text = "delete_history.title".localized
    }

    func setup() {
        contentView.backgroundColor = BelaTheme.shared.backgroundColor2
        label.textColor = .red
    }

}
