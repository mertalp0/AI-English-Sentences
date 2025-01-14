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
            return "The email address is not valid."
        case .wrongPassword:
            return "The password is incorrect."
        case .userNotFound:
            return "User not found. Please register first."
        case .userAlreadyExists:
            return "User already exists. Please try logging in."
        case .weakPassword:
            return "The password is too weak. Please choose a stronger password."
        case .networkError:
            return "Network error occurred. Please check your internet connection."
        case .unknownError:
            return "An unknown error occurred. Please try again."
        case .userNotLoggedIn:
            return "User is not logged in."
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
