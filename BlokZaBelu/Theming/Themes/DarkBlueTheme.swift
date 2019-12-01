//
//  DarkBlueTheme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

struct DarkBlueTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .black }
    
    var backgroundColor2: UIColor { return UIColor(white: 35.0 / 255.0, alpha: 1.0) }
    
    var backgroundColor3: UIColor { .lightGray }
    
    var placeholderColor: UIColor { return .black }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .blue }
        
    var themeContrastColor: UIColor { .red }
    
    var textColor: UIColor { return .white }
    
    var textColor2: UIColor { return .white }

    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}
