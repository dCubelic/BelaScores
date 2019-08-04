//
//  ResilienceArray.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

class ResilienceArray<T: Hashable> {
    
    private var array: [[T]]
    private var counter: Int
    private var dictionary: [T: Int] = [:]
    
    init(size: Int) {
        self.array = [[T]](repeating: [], count: size)
        self.counter = 0
    }
    
    func add(items: [T]) {
        for oldItem in array[counter] {
            if let value = dictionary[oldItem] {
                dictionary[oldItem] = value - 1
            } else {
                dictionary[oldItem] = 0
            }
        }
        self.array[counter] = items
        for newItem in array[counter] {
            if let value = dictionary[newItem] {
                dictionary[newItem] = value + 1
            } else {
                dictionary[newItem] = 1
            }
        }
        counter += 1
        if counter == array.count {
            counter = 0
        }
    }
    
    func numberOfOccurences(item: T) -> Int {
        return dictionary[item] ?? 0
    }
}
