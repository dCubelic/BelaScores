//
//  BelaSuit.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 05/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

public enum BelaSuit: String {
    case hearts, diamonds, spades, clubs
    
    var imageName: String {
        return self.rawValue
    }
}
