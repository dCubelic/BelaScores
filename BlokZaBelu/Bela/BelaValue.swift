//
//  BelaValuye.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 05/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

enum BelaValue: String {
    case ace, king, queen, jack, ten, nine, eight, seven
    
    var pointValue: Int {
        switch self {
        case .seven, .eight, .nine:
            return 0
        case .ten:
            return 10
        case .jack:
            return 2
        case .queen:
            return 3
        case .king:
            return 4
        case .ace:
            return 11
        }
    }
    
    var trumpPointValue: Int {
        switch self {
        case .seven, .eight:
            return 0
        case .nine:
            return 14
        case .ten:
            return 10
        case .jack:
            return 20
        case .queen:
            return 3
        case .king:
            return 4
        case .ace:
            return 11
        }
    }
    
    var string: String {
        switch self {
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        case .ace:
            return "A"
        }
    }
}
