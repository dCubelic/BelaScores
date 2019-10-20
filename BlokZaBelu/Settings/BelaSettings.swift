//
//  BelaSettings.swift
//  BlokZaBelu
//
//  Created by dominik on 18/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

class BelaSettings {
    public static let shared = BelaSettings()
    
    private init() {}
    
    public var invertScores: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "invertScores")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "invertScores")
        }
    }
}
