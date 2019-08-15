//
//  KeyboardToolbar.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 15/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol KeyboardToolbarDelegate: class {
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar)
}

class KeyboardToolbar: UIToolbar {
    
    weak var toolBarDelegate: KeyboardToolbarDelegate?
    
    init() {
        super.init(frame: .zero)
        
        sizeToFit()
        barStyle = UIBarStyle.default
//        isTranslucent = true
        isUserInteractionEnabled = true
    }
    
    func setup(leftButtons: [KeyboardToolbarButton], rightButtons: [KeyboardToolbarButton]) {
        
        let leftBarButtons = leftButtons.map { item -> UIBarButtonItem in
            item.createButton(target: self, action: #selector(buttonTapped))
        }
        
        let rightBarButtons = rightButtons.map { item -> UIBarButtonItem in
            item.createButton(target: self, action: #selector(buttonTapped(sender:)))
        }
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        setItems(leftBarButtons + [spaceButton] + rightBarButtons, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func buttonTapped(sender: UIBarButtonItem) {
        if let type = KeyboardToolbarButton.detectType(barButton: sender) {
            toolBarDelegate?.keyboardToolbar(button: sender, type: type, tappedIn: self)
        }
    }
    
}
