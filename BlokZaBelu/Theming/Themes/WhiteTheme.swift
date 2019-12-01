//
//  DarkWhiteTheme.swift
//  BlokZaBelu
//
//  Created by dominik on 23/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

import UIKit

struct WhiteTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .darkGray }
    
    var backgroundColor2: UIColor { return .darkGray2 }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var placeholderColor: UIColor { return .darkGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .white }
    
    var themeContrastColor: UIColor { return .red }
    
    var textColor: UIColor { return .white }
    
    var textColor2: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}
