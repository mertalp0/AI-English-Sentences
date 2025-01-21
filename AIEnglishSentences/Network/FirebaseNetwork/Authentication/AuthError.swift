//
//  AuthError.swift
//  AIEnglishSentences
//
//  Created by mert alp on 11.01.2025.
//

import Foundation
import FirebaseAuth

enum AuthError: LocalizedError {
    case invalidEmail
    case wrongPassword
    case userNotFound
    case userAlreadyExists
    case weakPassword
    case networkError
    case unknownError
    case userNotLoggedIn
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return .localized(for: .errorInvalidEmail)
        case .wrongPassword:
            return .localized(for: .errorWrongPassword)
        case .userNotFound:
            return .localized(for: .errorUserNotFound)
        case .userAlreadyExists:
            return .localized(for: .errorUserAlreadyExists)
        case .weakPassword:
            return .localized(for: .errorWeakPassword)
        case .networkError:
            return .localized(for: .errorNetwork)
        case .unknownError:
            return .localized(for: .errorUnknown)
        case .userNotLoggedIn:
            return .localized(for: .errorUserNotFound)
        case .custom(let message):
            return message
        }
    }

    static func map(from error: Error) -> AuthError {
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.invalidEmail.rawValue:
            return .invalidEmail
        case AuthErrorCode.wrongPassword.rawValue:
            return .wrongPassword
        case AuthErrorCode.userNotFound.rawValue:
            return .userNotFound
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return .userAlreadyExists
        case AuthErrorCode.weakPassword.rawValue:
            return .weakPassword
        case NSURLErrorNotConnectedToInternet:
            return .networkError
        default:
            return .unknownError
        }
    }
}
