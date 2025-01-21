//
//  FirebaseError.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import Foundation

enum FirebaseError: LocalizedError {
    case missingDocument
    case decodingFailed
    case documentAlreadyExists
    case unknown

    var errorDescription: String? {
        switch self {
        case .missingDocument:
            return LocalizationManager.shared.localized(for: .errorMissingDocument)
        case .decodingFailed:
            return LocalizationManager.shared.localized(for: .errorDecodingFailed)
        case .documentAlreadyExists:
            return LocalizationManager.shared.localized(for: .errorDocumentAlreadyExists)
        case .unknown:
            return LocalizationManager.shared.localized(for: .errorUnknown)
        }
    }
}
