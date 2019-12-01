//
//  ThemeProtocol.swift
//  BlokZaBelu
//
//  Created by dominik on 23/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var backgroundColor: UIColor { get }
    var backgroundColor2: UIColor { get }
    var backgroundColor3: UIColor { get }
    var placeholderColor: UIColor { get }
    var transparentBackgroundColor: UIColor { get }
    var themeColor: UIColor { get }
    var themeContrastColor: UIColor { get }
    var textColor: UIColor { get }
    var textColor2: UIColor { get }
    var statusBarStyle: UIStatusBarStyle { get }
}
