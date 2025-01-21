//
//  LocalizationManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 17.12.2024.
//

import Foundation

// MARK: - LocalizationManager
final class LocalizationManager {
    static let shared = LocalizationManager()

    private init() {}

    func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    func localized(for key: LocalizationKeys) -> String {
        return localizedString(forKey: key.rawValue)
    }
}
