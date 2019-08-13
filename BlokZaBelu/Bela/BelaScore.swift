//
//  BelaScore.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 13/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

struct BelaScore {
    var biddingTeam: BelaTeam
    var gameScore: BelaGameScore
    var declarationsTeam1: [Int]
    var declarationsTeam2: [Int]
    
    var totalScore: Int {
        return gameScore.score1 + declarationsTeam1.reduce(0, +)
    }
    
    var totalScore2: Int {
        return gameScore.score2 + declarationsTeam2.reduce(0, +)
    }
}
