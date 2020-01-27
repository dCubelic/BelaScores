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
    var team1Name: BelaTeamName
    var team2Name: BelaTeamName
    
    static var lastConfiguration: BelaMatchSettings {
        // bolje slozit ovo s imenima. mozda bi fora bilo da su u novoj rundi ista imena ko u prosloj,
        // al samo ak je runda u nekom manjem razdoblju nakon zadnje. inace mi / vi
        let team1Name: BelaTeamName = .us
        let team2Name: BelaTeamName = .them
        let maxGameScore = BelaMaxMatchScore(rawValue: UserDefaults.standard.integer(forKey: "maxMatchScore")) ?? .fiveHundredOne
        let tieBreaker = BelaTieBreaker(rawValue: UserDefaults.standard.string(forKey: "tieBreaker") ?? "") ?? .moreThan
        let endType = BelaEndType(rawValue: UserDefaults.standard.string(forKey: "endType") ?? "") ?? .afterGame
        
        return BelaMatchSettings(maxGameScore: maxGameScore, tieBreaker: tieBreaker, endType: endType, team1Name: team1Name, team2Name: team2Name)
    }
}
