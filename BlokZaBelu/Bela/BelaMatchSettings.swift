//
//  BelaMatchSettings.swift
//  BlokZaBelu
//
//  Created by dominik on 27/01/2020.
//  Copyright © 2020 Dominik Cubelic. All rights reserved.
//

import Foundation

enum BelaMaxMatchScore: Int, Codable {
    case fiveHundredOne = 501
    case sevenHunderOne = 701
    case thousandOne = 1001
}

enum BelaTieBreaker: String, Codable {
    case moreThan
    case moreOrEqual
}

enum BelaEndType: String, Codable {
    case duringGame
    case afterGame
}

struct BelaMatchSettings: Codable {
    var maxGameScore: BelaMaxMatchScore
    var tieBreaker: BelaTieBreaker
    var endType: BelaEndType
    var team1Name: String
    var team2Name: String
    
    static var lastConfiguration: BelaMatchSettings {
        let team1Name: String = "team1_default_name"
        let team2Name: String = "team2_default_name"
        let maxGameScore = BelaMaxMatchScore(rawValue: UserDefaults.standard.integer(forKey: "maxMatchScore")) ?? .thousandOne
        let tieBreaker = BelaTieBreaker(rawValue: UserDefaults.standard.string(forKey: "tieBreaker") ?? "") ?? .moreThan
        let endType = BelaEndType(rawValue: UserDefaults.standard.string(forKey: "endType") ?? "") ?? .afterGame
        
        return BelaMatchSettings(maxGameScore: maxGameScore, tieBreaker: tieBreaker, endType: endType, team1Name: team1Name, team2Name: team2Name)
    }
}
