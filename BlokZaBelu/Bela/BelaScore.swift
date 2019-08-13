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
    
    private var _totalScore: Int {
        return gameScore.score1 + declarationsTeam1.reduce(0, +)
    }
    
    private var _totalScore2: Int {
        return gameScore.score2 + declarationsTeam2.reduce(0, +)
    }
    
    var team1Passed: Bool {
        return biddingTeam == .team1 ? _totalScore > _totalScore2 : true
    }
    
    var team2Passed: Bool {
        return biddingTeam == .team2 ? _totalScore2 > _totalScore : true
    }
    
    var totalScore: Int {
        return !team1Passed ? 0 : (!team2Passed ? _totalScore + _totalScore2 : _totalScore)
    }
    
    var totalScore2: Int {
        return !team2Passed ? 0 : (!team1Passed ? _totalScore + _totalScore2 : _totalScore2)
    }
}
