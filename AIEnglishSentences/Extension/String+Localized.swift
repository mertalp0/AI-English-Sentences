//
//  String+Localized.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

extension String {
    static func localized(for key: LocalizationKeys) -> String {
        return LocalizationManager.shared.localizedString(forKey: key.rawValue)
    }
}
