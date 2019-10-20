//
//  BelaColors.swift
//  BlokZaBelu
//
//  Created by dominik on 20/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

enum Theme: String {
    case `default`
    case white
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
        switch theme {
        case .default:
            return .darkGray
        case .white:
            return .white
        }
    }
    
    var backgroundColor2: UIColor {
        switch theme {
        case .default:
            return .darkGray2
        case .white:
            return UIColor.black.withAlphaComponent(0.2)
        }
    }
    
    var backgroundColor3: UIColor {
        switch theme {
        case .default:
            return .lightGray
        case .white:
            return UIColor.black.withAlphaComponent(0.4)
        }
    }
    
    var transparentBackgroundColor: UIColor {
        switch theme {
        case .default:
            return .transparentBlack
        case .white:
            return UIColor.black.withAlphaComponent(0.4)
        }
    }
    
    var themeColor: UIColor {
        switch theme {
        case .default:
            return .blue
        case .white:
            return .red
        }
    }
    
    var themeContrastColor: UIColor {
        switch theme {
        case .default:
            return .red
        case .white:
            return .black
        }
    }
    
    var textColor: UIColor {
        switch theme {
        case .default:
            return .white
        case .white:
            return .black
        }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        switch theme {
        case .default:
            return .lightContent
        case .white:
            return .default
        }
    }
    
    private init() { }
}
