//
//  BelaPrediction.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

enum BelaSuit: String {
    case hearts, diamonds, spades, clubs
    
    var imageName: String {
        return self.rawValue
    }
}

enum BelaValue: String {
    case ace, king, queen, jack, ten, nine, eight, seven
    
    var pointValue: Int {
        switch self {
        case .seven, .eight, .nine:
            return 0
        case .ten:
            return 10
        case .jack:
            return 2
        case .queen:
            return 3
        case .king:
            return 4
        case .ace:
            return 11
        }
    }
    
    var trumpPointValue: Int {
        switch self {
        case .seven, .eight:
            return 0
        case .nine:
            return 14
        case .ten:
            return 10
        case .jack:
            return 20
        case .queen:
            return 3
        case .king:
            return 4
        case .ace:
            return 11
        }
    }
    
    var string: String {
        switch self {
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        case .ace:
            return "A"
        }
    }
}

enum BelaCard: String {
    case aceOfHearts, kingOfHearts, queenOfHearts, jackOfHearts, tenOfHearts, nineOfHearts, eightOfHearts, sevenOfHearts
    case aceOfDiamonds, kingOfDiamonds, queenOfDiamonds, jackOfDiamonds, tenOfDiamonds, nineOfDiamonds, eightOfDiamonds, sevenOfDiamonds
    case aceOfSpades, kingOfSpades, queenOfSpades, jackOfSpades, tenOfSpades, nineOfSpades, eightOfSpades, sevenOfSpades
    case aceOfClubs, kingOfClubs, queenOfClubs, jackOfClubs, tenOfClubs, nineOfClubs, eightOfClubs, sevenOfClubs
    
    static let cards: [BelaCard] = [
        aceOfHearts, kingOfHearts, queenOfHearts, jackOfHearts, tenOfHearts, nineOfHearts, eightOfHearts, sevenOfHearts,
        aceOfDiamonds, kingOfDiamonds, queenOfDiamonds, jackOfDiamonds, tenOfDiamonds, nineOfDiamonds, eightOfDiamonds, sevenOfDiamonds,
        aceOfClubs, kingOfClubs, queenOfClubs, jackOfClubs, tenOfClubs, nineOfClubs, eightOfClubs, sevenOfClubs,
        aceOfSpades, kingOfSpades, queenOfSpades, jackOfSpades, tenOfSpades, nineOfSpades, eightOfSpades, sevenOfSpades
                                    ]
    
    var value: BelaValue {
        return BelaValue(rawValue: self.rawValue.components(separatedBy: "Of")[0].lowercased())!
    }
    
    var suit: BelaSuit {
        return BelaSuit(rawValue: self.rawValue.components(separatedBy: "Of")[1].lowercased())!
    }
    
    func points(trumpSuit: BelaSuit) -> Int {
        if suit == trumpSuit {
            return value.trumpPointValue
        }
        
        return value.pointValue
    }
}

struct BelaPrediction: Hashable {
    let card: BelaCard
    let confidence: Float
    
    init(classIndex: Int, confidence: Float) {
        self.card = BelaCard.cards[classIndex]
        self.confidence = confidence
    }
}
