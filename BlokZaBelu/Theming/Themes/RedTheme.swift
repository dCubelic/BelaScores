//
//  RedTheme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

struct RedTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .black }
    
    var backgroundColor2: UIColor { return UIColor(white: 35.0 / 255.0, alpha: 1.0) }
    
    var backgroundColor3: UIColor { .lightGray }
    
    var placeholderColor: UIColor { return .black }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .red }
    
    var themeContrastColor: UIColor { return UIColor(white: 170.0 / 255.0, alpha: 1.0) }
    
    var textColor: UIColor { return UIColor(white: 170.0 / 255.0, alpha: 1.0) }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var logoName: String { return "logo_red" }
}
