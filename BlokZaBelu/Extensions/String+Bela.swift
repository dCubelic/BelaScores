//
//  String+Bela.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 15/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var belaName: String {
        if self == "team1_default_name" || self == "team2_default_name" {
            return self.localized
        }
        return self.uppercased()
    }
}
