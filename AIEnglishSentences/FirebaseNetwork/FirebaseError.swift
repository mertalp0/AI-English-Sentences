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
    case unknown

    var errorDescription: String? {
        switch self {
        case .missingDocument:
            return "The requested document is missing."
        case .decodingFailed:
            return "Failed to decode the document."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
