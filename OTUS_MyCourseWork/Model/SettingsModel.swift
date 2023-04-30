//
//  SettingsModel.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 23.04.2023.
//

import Foundation

struct GameSettings {
    var audio: Bool = true
    var language: Language = Language.eng
}

enum Language: String {
    case ru = "Русский"
    case eng = "English"
}
