//
//  Score.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import BelaDetectorFramework
import Foundation

struct BelaGameScore: Codable {
    
    var score1: Int = 0
    var score2: Int = 0
    
    init(score1: Int) {
        self.score1 = score1
        self.score2 = BelaGameScore.total - score1
    }
    
    init(score2: Int) {
        self.score2 = score2
        self.score1 = BelaGameScore.total - score2
    }
    
    static let total = 162
    
}
