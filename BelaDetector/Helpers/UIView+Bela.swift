//
//  UIView+Bela.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 05/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadViewFromNib() -> UIView? {
        backgroundColor = .clear
        
        let type = Swift.type(of: self)
        let bundle = Bundle(for: type)
        if let view = bundle.loadNibNamed(String(describing: type), owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            addSubview(view)
            
            return view
        }
        
        return nil
    }
    
}
