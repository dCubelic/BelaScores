//
//  BelaMatch.swift
//  BlokZaBelu
//
//  Created by dominik on 24/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

struct BelaMatch: Codable, Equatable {
    
    var scores: [BelaScore]
    var dateCreated: Date
    var matchSettings: BelaMatchSettings = .lastConfiguration
    
    var team1Score: Int {
        return scores.reduce(0) { $0 + $1.totalScoreTeam1 }
    }
    
    var team2Score: Int {
        return scores.reduce(0) { $0 + $1.totalScoreTeam2 }
    }
    
    var winningTeam: BelaTeam? {
        if team1Score >= matchSettings.maxGameScore.rawValue && team1Score > team2Score {
            return .team1
        } else if team2Score >= matchSettings.maxGameScore.rawValue && team2Score > team1Score {
            return .team2
        }
        return nil
    }
    
    static var newMatch = BelaMatch(scores: [], dateCreated: Date())
    
    static var dummyMatch = BelaMatch(scores: [
        BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 32), declarationsTeam1: [], declarationsTeam2: [20]),
        BelaScore(biddingTeam: .team1, gameScore: BelaGameScore(score1: 110), declarationsTeam1: [], declarationsTeam2: [50]),
        BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 120), declarationsTeam1: [], declarationsTeam2: []),
        BelaScore(biddingTeam: .team1, gameScore: BelaGameScore(score1: 82), declarationsTeam1: [], declarationsTeam2: []),
        BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 100), declarationsTeam1: [], declarationsTeam2: [50])
    ], dateCreated: Date())
    
    static func randomDummyMatch(team1Name: BelaTeamName = .us, team2Name: BelaTeamName = .them) -> BelaMatch {
        var scores: [BelaScore] = []
        var sumTeam1 = 0
        var sumTeam2 = 0
        while sumTeam1 < 1001 && sumTeam2 < 1001 {
            let team1Points = Int.random(in: 0...162)
            let score = BelaScore(biddingTeam: Bool.random() ? .team1 : .team2, gameScore: BelaGameScore(score1: team1Points), declarationsTeam1: [], declarationsTeam2: [])
            sumTeam1 += score.totalScoreTeam1
            sumTeam2 += score.totalScoreTeam2
            scores.append(score)
        }
//        return BelaMatch()
        return BelaMatch(scores: scores, dateCreated: Date(timeIntervalSince1970: TimeInterval(Int.random(in: 1574290938...1575327738))))
    }
    
    static func == (lhs: BelaMatch, rhs: BelaMatch) -> Bool {
        return lhs.dateCreated == rhs.dateCreated
    }
    
}
