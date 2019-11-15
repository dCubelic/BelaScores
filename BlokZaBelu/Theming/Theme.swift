//
//  Theme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

enum Theme: String {
    case `default`
    case green
    case red
    case light
    case white
    
    private var themeImplementation: ThemeProtocol {
        switch self {
        case .default:
            return BlueTheme()
        case .green:
            return GreenTheme()
        case .red:
            return RedTheme()
        case .light:
            return LightTheme()
        case .white:
            return WhiteTheme()
        }
    }
    
    var backgroundColor: UIColor { return themeImplementation.backgroundColor }
    var backgroundColor2: UIColor { return themeImplementation.backgroundColor2 }
    var backgroundColor3: UIColor { return themeImplementation.backgroundColor3 }
    var placeholderColor: UIColor { return themeImplementation.placeholderColor }
    var transparentBackgroundColor: UIColor { return themeImplementation.transparentBackgroundColor }
    var themeColor: UIColor { return themeImplementation.themeColor }
    var themeContrastColor: UIColor { return themeImplementation.themeContrastColor }
    var textColor: UIColor { return themeImplementation.textColor }
    var statusBarStyle: UIStatusBarStyle { return themeImplementation.statusBarStyle }
    var logoName: String { return themeImplementation.logoName }
}
