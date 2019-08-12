//
//  Bundle+Bela.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

extension Bundle {
    
    static var frameworkBundle: Bundle {
        return Bundle(for: BelaDetectorViewController.self)
    }
    
}
