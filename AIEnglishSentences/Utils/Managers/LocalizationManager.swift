//
//  LocalizationManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 17.12.2024.
//

import Foundation

enum LocalizationKeys: String {
    // Shared Strings
    case googleButtonTitle = "google_button_title"
    case appleButtonTitle = "apple_button_title"
    case orText = "or_text"
    case login = "login"
    case signup = "signup"
    case emailPlaceholder = "email_placeholder"
    case emailTitle = "email_title"
    case passwordPlaceholder = "password_placeholder"
    case passwordTitle = "password_title"
    case validationEmail = "validation_email"
    case validationPassword = "validation_password"
    case dontHaveAccount = "dont_have_account"
    
    //InfoCV Strings
    case infoSubTitle = "info_subtitle"
    
    // LoginVC Strings
    case loginTitle = "login_title"
    case loginSubtitle = "login_subtitle"
    case forgotPassword = "forgot_password"
    
    // RegisterVC Strings
    case createAccountTitle = "create_account_title"
    case registerSubtitle = "register_subtitle"
    case namePlaceholder = "name_placeholder"
    case nameTitle = "name_title"
    case alreadyHaveAccount = "already_have_account"
    case loginHighlighted = "login_highlighted"
    case validationName = "validation_name"
}

final class LocalizationManager {
    
    static let shared = LocalizationManager()
    
    private init() {}
    
    
    // Localized string fetcher
    func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension String {
    static func localized(for key: LocalizationKeys) -> String {
        
        return LocalizationManager.shared.localizedString(forKey: key.rawValue)
    }
}
