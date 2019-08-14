//
//  BelaScore.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 13/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

struct BelaScore: Codable {
    var biddingTeam: BelaTeam
    var gameScore: BelaGameScore
    var declarationsTeam1: [Int]
    var declarationsTeam2: [Int]
    
    private var _totalScoreTeam1: Int {
        return gameScore.score1 + declarationsTeam1.reduce(0, +)
    }
    
    private var _totalScoreTeam2: Int {
        return gameScore.score2 + declarationsTeam2.reduce(0, +)
    }
    
    var team1Passed: Bool {
        return biddingTeam == .team1 ? _totalScoreTeam1 > _totalScoreTeam2 : true
    }
    
    var team2Passed: Bool {
        return biddingTeam == .team2 ? _totalScoreTeam2 > _totalScoreTeam1 : true
    }
    
    var totalScoreTeam1: Int {
        return !team1Passed ? 0 : (!team2Passed ? _totalScoreTeam1 + _totalScoreTeam2 : _totalScoreTeam1)
    }
    
    var totalScoreTeam2: Int {
        return !team2Passed ? 0 : (!team1Passed ? _totalScoreTeam1 + _totalScoreTeam2 : _totalScoreTeam2)
    }
    
    var isValidScore: Bool {
        if gameScore.score1 < 0 || gameScore.score2 < 0 { return false }
        if gameScore.score1 == 1 || gameScore.score2 == 1 { return false }
        
        return true
    }
}
