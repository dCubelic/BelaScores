//
//  UIStoryboard+Bela.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType: T.Type, withIdentifier: String? = nil) -> T {
        let identifier = withIdentifier ?? String(describing: ofType)
        
        guard let viewController = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Storyboard \(self) doesn't contain a view controller of type \(ofType) for identifier \(identifier)")
        }
        
        return viewController
    }
 
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
