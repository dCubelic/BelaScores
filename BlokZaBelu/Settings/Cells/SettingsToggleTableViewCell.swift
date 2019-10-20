//
//  SettingsToggleTableViewCell.swift
//  BlokZaBelu
//
//  Created by dominik on 18/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol SettingsToggleTableViewCellDelegate: class {
    func settingsToggleTableViewCellDidSwitch(_ cell: SettingsToggleTableViewCell, to isOn: Bool)
}

class SettingsToggleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var `switch`: UISwitch!
    
    weak var delegate: SettingsToggleTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    public func setup(title: String, isOn: Bool) {
        titleLabel.text = title
        `switch`.isOn = isOn
    }
    
    @IBAction private func switchAction(_ sender: Any) {
        delegate?.settingsToggleTableViewCellDidSwitch(self, to: `switch`.isOn)
    }
    
}
