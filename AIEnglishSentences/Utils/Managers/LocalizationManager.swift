//
//  LocalizationManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 17.12.2024.
//

import Foundation

final class LocalizationManager {
    
    // Singleton instance
    static let shared = LocalizationManager()
    
    // App Strings
    enum LocalizationKeys {
        static let example = "example"
       
    }
    
    private init() {}
    
    // Localized string fetcher
    static func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    
    func example() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.example)
    }
}
