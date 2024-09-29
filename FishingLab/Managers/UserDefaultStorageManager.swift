//
//  UserDefaultStorageManager.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 21.09.2024.
//

import SwiftUI
import Foundation

enum Keys: String {
    case isFirstLaunch
}

final class UserDefaultStorageManager : ObservableObject {
    // Define keys for UserDefaults
    static let shared = UserDefaultStorageManager()
    
    private let defaults = UserDefaults.standard
    
    // Save a string value (for example, user token)
    func setValue(value data: Any, key : Keys) {
        defaults.set(data, forKey: key.rawValue)
    }
    
    func getStringValue(key : Keys) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    // Remove all saved data (useful for logout)
    func clearAll() {
        defaults.removeObject(forKey: Keys.isFirstLaunch.rawValue)
    }
}

