//
//  AuthError.swift
//  AIEnglishSentences
//
//  Created by mert alp on 8.01.2025.
//

import Foundation

enum AuthError: Error {
    case userNotLoggedIn
    case invalidCredentials
    case userReauthenticationFailed
    case accountDeletionFailed
    case networkError
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .userNotLoggedIn:
            return "User is not logged in. Please log in and try again."
        case .invalidCredentials:
            return "The provided credentials are invalid. Please check your email and password."
        case .userReauthenticationFailed:
            return "Reauthentication failed. Please log in again to continue."
        case .accountDeletionFailed:
            return "Failed to delete the account. Please try again later."
        case .networkError:
            return "A network error occurred. Please check your internet connection and try again."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        }
    }
}
