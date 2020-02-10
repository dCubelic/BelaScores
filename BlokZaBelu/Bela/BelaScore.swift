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
    
    func team1Passed(tieBreaker: BelaTieBreaker) -> Bool {
        if biddingTeam == .team2 { return true }
        if gameScore.score1 == 0 { return false }
        switch tieBreaker {
        case .moreThan:
            return _totalScoreTeam1 > _totalScoreTeam2
        case .moreOrEqual:
            return _totalScoreTeam1 >= _totalScoreTeam2
        }
    }
    
    func team2Passed(tieBreaker: BelaTieBreaker) -> Bool {
        if biddingTeam == .team1 { return true }
        if gameScore.score2 == 0 { return false }
        switch tieBreaker {
        case .moreThan:
            return _totalScoreTeam2 > _totalScoreTeam1
        case .moreOrEqual:
            return _totalScoreTeam2 >= _totalScoreTeam1
        }
    }
    
//    var team1Passed: Bool {
//        if biddingTeam == .team2 { return true }
//        if gameScore.score1 == 0 { return false }
//        return _totalScoreTeam1 >= _totalScoreTeam2
//    }
//
//    var team2Passed: Bool {
//        if biddingTeam == .team1 { return true }
//        if gameScore.score2 == 0 { return false }
//        return _totalScoreTeam2 >= _totalScoreTeam1
//    }
    
    func totalScoreTeam1(tieBreaker: BelaTieBreaker) -> Int {
        if gameScore.score1 == 0 { return 0 }
        if !team1Passed(tieBreaker: tieBreaker) { return 0}
        
        return team2Passed(tieBreaker: tieBreaker) && gameScore.score2 != 0 ? _totalScoreTeam1 : _totalScoreTeam1 + _totalScoreTeam2
    }
    
    func totalScoreTeam2(tieBreaker: BelaTieBreaker) -> Int {
        if gameScore.score2 == 0 { return 0 }
        if !team2Passed(tieBreaker: tieBreaker) { return 0}
        
        return team1Passed(tieBreaker: tieBreaker) && gameScore.score1 != 0 ? _totalScoreTeam2 : _totalScoreTeam1 + _totalScoreTeam2
    }
    
//    var totalScoreTeam1: Int {
//        if gameScore.score1 == 0 { return 0 }
//        if !team1Passed { return 0 }
//        
//        return team2Passed && gameScore.score2 != 0 ? _totalScoreTeam1 : _totalScoreTeam1 + _totalScoreTeam2
//    }
//    
//    var totalScoreTeam2: Int {
//        if gameScore.score2 == 0 { return 0 }
//        if !team2Passed { return 0 }
//        
//        return team1Passed && gameScore.score1 != 0 ? _totalScoreTeam2 : _totalScoreTeam1 + _totalScoreTeam2
//    }
    
    var isValidScore: Bool {
        if gameScore.score1 < 0 || gameScore.score2 < 0 { return false }
        if gameScore.score1 == 1 || gameScore.score2 == 1 { return false }
        
        return true
    }
    
}
