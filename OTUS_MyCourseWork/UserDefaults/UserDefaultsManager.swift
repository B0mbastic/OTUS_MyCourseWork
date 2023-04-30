//
//  UserDefaultsManager.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 25.04.2023.
//

import Foundation

final class UserDefaultsManager {
    private static let defaults = UserDefaults.standard
    private enum Keys: String {
        case isAudioOnKey
    }
    static var isAudioOn: Bool {
        get {
            return defaults.bool(forKey: Keys.isAudioOnKey.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: Keys.isAudioOnKey.rawValue)
        }
    }
    
}
