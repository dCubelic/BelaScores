//
//  UIView+Bela.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 11/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

extension UIView {
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
    
}
