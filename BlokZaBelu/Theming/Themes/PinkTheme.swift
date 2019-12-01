//
//  PinkTheme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

struct PinkTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .darkGray }
    
    var backgroundColor2: UIColor { return .darkGray2 }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var placeholderColor: UIColor { return .darkGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return UIColor(red: 244.0 / 255.0, green: 29.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0) }
    
    var themeContrastColor: UIColor { return .red }
    
    var textColor: UIColor { return .white }
    
    var textColor2: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}
