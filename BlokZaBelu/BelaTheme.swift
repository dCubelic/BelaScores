//
//  BelaColors.swift
//  BlokZaBelu
//
//  Created by dominik on 20/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var backgroundColor: UIColor { get }
    var backgroundColor2: UIColor { get }
    var backgroundColor3: UIColor { get }
    var transparentBackgroundColor: UIColor { get }
    var themeColor: UIColor { get }
    var themeContrastColor: UIColor { get }
    var textColor: UIColor { get }
    var statusBarStyle: UIStatusBarStyle { get }
}

struct BlueTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .darkGray }
    
    var backgroundColor2: UIColor { return .darkGray2 }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .blue }
    
    var themeContrastColor: UIColor { return .red }
    
    var textColor: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}

struct GreenTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .darkGray }
    
    var backgroundColor2: UIColor { return .darkGray2 }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .green }
    
    var themeContrastColor: UIColor { return .red }
    
    var textColor: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}

struct RedTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .black }
    
    var backgroundColor2: UIColor { return .darkGray }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .red }
    
    var themeContrastColor: UIColor { return .black }
    
    var textColor: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}

enum Theme: String {
    case `default`
    case green
    case red
    
    private var themeImplementation: ThemeProtocol {
        switch self {
        case .default:
            return BlueTheme()
        case .green:
            return GreenTheme()
        case .red:
            return RedTheme()
        }
    }
    
    var backgroundColor: UIColor { return themeImplementation.backgroundColor }
    var backgroundColor2: UIColor { return themeImplementation.backgroundColor2 }
    var backgroundColor3: UIColor { return themeImplementation.backgroundColor3 }
    var transparentBackgroundColor: UIColor { return themeImplementation.transparentBackgroundColor }
    var themeColor: UIColor { return themeImplementation.themeColor }
    var themeContrastColor: UIColor { return themeImplementation.themeContrastColor }
    var textColor: UIColor { return themeImplementation.textColor }
    var statusBarStyle: UIStatusBarStyle { return themeImplementation.statusBarStyle }
}

class BelaTheme {
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
    
    var statusBarStyle: UIStatusBarStyle {
        return theme.statusBarStyle
    }
    
    private init() { }
}
