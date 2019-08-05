//
//  BelaPrediction.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 05/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

struct BelaPrediction: Hashable {
    let card: BelaCard
    let confidence: Float
    
    init(classIndex: Int, confidence: Float) {
        self.card = BelaCard.cards[classIndex]
        self.confidence = confidence
    }
}
