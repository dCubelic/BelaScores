//
//  Theme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

enum Theme: String, CaseIterable {
    case `default`
    case green
    case yellow
    case orange
    case red
    case pink
    case white
    case darkBlue
    case darkGreen
    case darkYellow
    case darkOrange
    case darkRed
    case darkPink
    case darkWhite
    case light
    
    private var themeImplementation: ThemeProtocol {
        switch self {
        case .default:
            return BlueTheme()
        case .darkBlue:
            return DarkBlueTheme()
        case .green:
            return GreenTheme()
        case .darkGreen:
            return DarkGreenTheme()
        case .red:
            return RedTheme()
        case .darkRed:
            return DarkRedTheme()
        case .light:
            return LightTheme()
        case .white:
            return WhiteTheme()
        case .darkWhite:
            return DarkWhiteTheme()
        case .orange:
            return OrangeTheme()
        case .darkOrange:
            return DarkOrangeTheme()
        case .yellow:
            return YellowTheme()
        case .darkYellow:
            return DarkYellowTheme()
        case .pink:
            return PinkTheme()
        case .darkPink:
            return DarkPinkTheme()
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
    var textColor2: UIColor { return themeImplementation.textColor2 }
    var statusBarStyle: UIStatusBarStyle { return themeImplementation.statusBarStyle }
}
