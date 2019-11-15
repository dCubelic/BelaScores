//
//  WhiteTheme.swift
//  BlokZaBelu
//
//  Created by dominik on 14/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

import UIKit

struct WhiteTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .black }
    
    var backgroundColor2: UIColor { return UIColor(white: 35.0 / 255.0, alpha: 1.0) }
    
    var backgroundColor3: UIColor { .lightGray }
    
    var placeholderColor: UIColor { return .black }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .white }
    
    var themeContrastColor: UIColor { return .red }
    
    var textColor: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var logoName: String { return "logo_white" }
}
