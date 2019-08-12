//
//  BelaPrediction.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

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
        guard let belaValue = BelaValue(rawValue: self.rawValue.components(separatedBy: "Of")[0].lowercased()) else {
            fatalError("Invalid bela card name!")
        }
        return belaValue
    }
    
    var suit: BelaSuit {
        guard let belaSuit = BelaSuit(rawValue: self.rawValue.components(separatedBy: "Of")[1].lowercased()) else {
            fatalError("Inavlid bela card name!")
        }
        return belaSuit
    }
    
    func points(trumpSuit: BelaSuit) -> Int {
        if suit == trumpSuit {
            return value.trumpPointValue
        }
        
        return value.pointValue
    }
}
