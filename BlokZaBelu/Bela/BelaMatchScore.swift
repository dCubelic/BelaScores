//
//  BelaMatchScore.swift
//  BlokZaBelu
//
//  Created by dominik on 24/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

struct BelaMatchScore: Codable, Equatable {
    
    var scores: [BelaScore]
    var team1Name: BelaTeamName = .us
    var team2Name: BelaTeamName = .them
    var date: Date
    var maxGameScore = 1001
    
    var team1Score: Int {
        return scores.reduce(0) { $0 + $1.totalScoreTeam1 }
    }
    
    var team2Score: Int {
        return scores.reduce(0) { $0 + $1.totalScoreTeam2 }
    }
    
    var winningTeam: BelaTeam? {
        if team1Score > team2Score {
            return .team1
        } else if team2Score > team1Score {
            return .team2
        }
        return nil
    }
    
    static var newMatch = BelaMatchScore(scores: [], date: Date())
    
    static var dummyMatch = BelaMatchScore(scores: [
        BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 32), declarationsTeam1: [], declarationsTeam2: [20]),
        BelaScore(biddingTeam: .team1, gameScore: BelaGameScore(score1: 110), declarationsTeam1: [], declarationsTeam2: [50]),
        BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 120), declarationsTeam1: [], declarationsTeam2: []),
        BelaScore(biddingTeam: .team1, gameScore: BelaGameScore(score1: 82), declarationsTeam1: [], declarationsTeam2: []),
        BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 100), declarationsTeam1: [], declarationsTeam2: [50])
    ], team1Name: BelaTeamName.custom("Cubi Ante"), team2Name: BelaTeamName.custom("Greba Vito"), date: Date())
    
    static func == (lhs: BelaMatchScore, rhs: BelaMatchScore) -> Bool {
        return lhs.date == rhs.date
    }
    
}
