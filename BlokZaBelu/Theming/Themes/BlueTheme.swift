//
//  Themes.swift
//  BlokZaBelu
//
//  Created by dominik on 23/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

struct BlueTheme: ThemeProtocol {
    var backgroundColor: UIColor { return .darkGray }
    
    var backgroundColor2: UIColor { return .darkGray2 }
    
    var backgroundColor3: UIColor { return .lightGray }
    
    var placeholderColor: UIColor { return .darkGray }
    
    var transparentBackgroundColor: UIColor { return .transparentBlack }
    
    var themeColor: UIColor { return .blue }
    
    var themeContrastColor: UIColor { return .red }
    
    var textColor: UIColor { return .white }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }
}
