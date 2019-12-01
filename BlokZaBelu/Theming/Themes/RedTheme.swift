//
//  RedTheme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

struct RedTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .darkGray }
    
    var backgroundColor2: UIColor { return .darkGray2 }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var placeholderColor: UIColor { return .darkGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return UIColor(red: 128.0 / 255.0, green: 7.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0) }
    
    var themeContrastColor: UIColor { .black }
    
    var textColor: UIColor { return .white }
    
    var textColor2: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}
