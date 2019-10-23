//
//  LightTheme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

struct LightTheme: ThemeProtocol {
    var backgroundColor: UIColor { return UIColor(white: 240.0 / 255.0, alpha: 1.0) }
    
    var backgroundColor2: UIColor { return .darkGray2 }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .yellow }
    
    var themeContrastColor: UIColor { return .red }
    
    var textColor: UIColor { return .black }
    
    var statusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}
