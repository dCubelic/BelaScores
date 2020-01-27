//
//  SettingsViewModel.swift
//  BlokZaBelu
//
//  Created by dominik on 20/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import Foundation

enum SettingType {
    case invertScores(String)
    case themes
    case deleteHistory
}

struct SettingSection {
    var description: String
    var settings: [SettingType]
}
