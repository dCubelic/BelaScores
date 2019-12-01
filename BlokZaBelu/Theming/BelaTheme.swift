//
//  BelaColors.swift
//  BlokZaBelu
//
//  Created by dominik on 20/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class BelaTheme: ThemeProtocol {
    public static let shared = BelaTheme()
    
    var theme: Theme {
        get {
            return Theme(rawValue: UserDefaults.standard.string(forKey: "BelaTheme") ?? "") ?? .default
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "BelaTheme")
        }
    }
    
    var backgroundColor: UIColor {
        return theme.backgroundColor
    }
    
    var backgroundColor2: UIColor {
        return theme.backgroundColor2
    }
    
    var backgroundColor3: UIColor {
        return theme.backgroundColor3
    }
    
    var placeholderColor: UIColor {
        return theme.placeholderColor
    }
    
    var transparentBackgroundColor: UIColor {
        return theme.transparentBackgroundColor
    }
    
    var themeColor: UIColor {
        return theme.themeColor
    }
    
    var themeContrastColor: UIColor {
        return theme.themeContrastColor
    }
    
    var textColor: UIColor {
        return theme.textColor
    }
    
    var textColor2: UIColor {
        return theme.textColor2
    }
    
    var statusBarStyle: UIStatusBarStyle {
        return theme.statusBarStyle
    }
    
    private init() { }
}
