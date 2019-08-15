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
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        
        flash.duration = 0.65
        flash.fromValue = 1
        flash.toValue = 0
        flash.autoreverses = true
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.repeatCount = .greatestFiniteMagnitude
        
        layer.add(flash, forKey: "opacity")
    }
    
    func stopFlash() {
        layer.removeAnimation(forKey: "opacity")
    }
    
}
