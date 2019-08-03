//
//  ResilienceArray.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

class ResilienceArray {
    
    private var array: [[BelaPrediction]]
    private var counter: Int
    private var dictionary: [BelaCard: Int] = [:]
    
    init(size: Int) {
        self.array = [[BelaPrediction]](repeating: [], count: size)
        self.counter = 0
    }
    
    func add(item: [BelaPrediction]) {
        for prediction in array[counter] {
            if let value = dictionary[prediction.card] {
                dictionary[prediction.card] = value - 1
            } else {
                dictionary[prediction.card] = 0
            }
        }
        self.array[counter] = item
        for prediction in array[counter] {
            if let value = dictionary[prediction.card] {
                dictionary[prediction.card] = value + 1
            } else {
                dictionary[prediction.card] = 1
            }
        }
        counter += 1
        if counter == array.count {
            counter = 0
        }
    }
    
    func numberOfOccurences(card: BelaCard) -> Int {
        return dictionary[card] ?? 0
    }
}
