//
//  BelaTeam.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 11/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

enum BelaTeam: String, Codable {
    case team1
    case team2
}

enum BelaTeamName: Codable {
    
    case us
    case them
    case custom(String)
    
    var string: String {
        switch self {
        case .us:
            return "us".localized
        case .them:
            return "them".localized
        case .custom(let name):
            return name
        }
    }
    
    init?(rawValue: String?) {
        guard let val = rawValue?.lowercased() else { return nil }
        switch val {
        case "us":
            self = .us
        case "them":
            self = .them
        default:
            self = .custom(val)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case us
        case them
        case custom
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .us:
            try container.encode("us", forKey: .us)
        case .them:
            try container.encode("them", forKey: .them)
        case .custom(let name):
            try container.encode(name, forKey: .custom)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey: .custom) {
            self = .custom(value)
        } else if let usValue = try? container.decode(String.self, forKey: .us), usValue == "us" {
            self = .us
        } else if let themValue = try? container.decode(String.self, forKey: .them), themValue == "them" {
            self = .them
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Data doesn't match"))
        }
    }
}
