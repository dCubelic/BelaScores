//
//  KeyboardToolbarButton.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 15/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

enum KeyboardToolbarButton: Int {
    
    case done = 0
    case cancel
    
    func createButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        var button: UIBarButtonItem
        
        switch self {
        case .done:
            button = UIBarButtonItem(title: "Done", style: .plain, target: target, action: action)
        case .cancel:
            button = UIBarButtonItem(title: "Cancel", style: .plain, target: target, action: action)
        }
        button.tag = rawValue
        button.tintColor = .blue
        
        return button
    }
    
    static func detectType(barButton: UIBarButtonItem) -> KeyboardToolbarButton? {
        return KeyboardToolbarButton(rawValue: barButton.tag)
    }
}
