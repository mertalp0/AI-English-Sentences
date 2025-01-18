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
    
    // Dashboard Strings
    case tabBarHistory = "tab_bar_history"
    case tabBarGenerate = "tab_bar_generate"
    case tabBarProfile = "tab_bar_profile"
    
    // History Strings
    case historySegmentAll = "history_segment_all"
    case historySegmentFavourites = "history_segment_favourites"
    
    // Empty State
    case historyEmptyAllTitle = "history_empty_all_title"
    case historyEmptyAllDescription = "history_empty_all_description"
    case historyEmptyFavouritesTitle = "history_empty_favourites_title"
    case historyEmptyFavouritesDescription = "history_empty_favourites_description"
    
    // Toast Messages
    case historyCopiedToClipboard = "history_copied_to_clipboard"
    
    // Delete Alert
    case historyDeleteAlertTitle = "history_delete_alert_title"
    case historyDeleteAlertMessage = "history_delete_alert_message"
    case historyDeleteAlertCancel = "history_delete_alert_cancel"
    case historyDeleteAlertConfirm = "history_delete_alert_confirm"
    case historyFetchErrorUserNotLoggedIn = "historyFetchErrorUserNotLoggedIn"
    
    // ContextaVC Strings
    case contextaSubtitle = "contextaSubtitle"
    case contextaCategoriesTitle = "contextaCategoriesTitle"
    
    // CategoryCell LocalizationKeys
    case categoryProfessionalTitle = "category_professional_title"
    case categoryProfessionalDescription = "category_professional_description"
    case categoryPersonalTitle = "category_personal_title"
    case categoryPersonalDescription = "category_personal_description"
    case categoryEducationalTitle = "category_educational_title"
    case categoryEducationalDescription = "category_educational_description"
    
    // Writing Tone Keys
    case toneFormal = "tone_formal"
    case toneFriendly = "tone_friendly"
    case toneCasual = "tone_casual"
    case toneInspirational = "tone_inspirational"
    case toneHumorous = "tone_humorous"
    
    // Writing Style Keys
    case stylePersuasive = "style_persuasive"
    case styleNarrative = "style_narrative"
    case styleDescriptive = "style_descriptive"
    case styleExplanatory = "style_explanatory"
    case styleCreative = "style_creative"
    
    // GenerateVC Keys
    case generateTitle = "generate_title"
    case writingToneTitle = "writing_tone_title"
    case writingStyleTitle = "writing_style_title"
    
    // CountSelectorView Keys
    case sentenceCountTitle = "sentence_count_title"
    case maxWordCountTitle = "max_word_count_title"
    
    // GenerateButton Keys
    case generateButtonTitle = "generate_button_title"
    
    // GenerateLoadingView Keys
    case generateLoadingTitle = "generate_loading_title"
    case generateLoadingDescription = "generate_loading_description"
    
    // GenerateTextView Keys
    case generateTextViewPlaceholder = "generate_textview_placeholder"
    
    // GenerateViewModel Strings
    case generateInputError = "generate_input_error"
    
    // ResultVC Strings
    case resultSuccessTitle = "result_success_title"
    case resultSuccessRegistrationMessage = "result_success_registration_message"
    case resultOkButton = "result_ok_button"
    case resultCopyToClipboard = "result_copy_to_clipboard"
    case resultSentenceRemovedSuccess = "result_sentence_removed_success"
    case resultSentenceRemovedError = "result_sentence_removed_error"
    case resultSentenceSavedSuccess = "result_sentence_saved_success"
    case resultSentenceSavedError = "result_sentence_saved_error"
    case sharedErrorMessage = "shared_error_message"
    
    // ProfileVC Strings
    case profileLanguage = "profile_language"
    case profilePrivacyPolicy = "profile_privacy_policy"
    case profileInviteFriends = "profile_invite_friends"
    case profileAppsByDeveloper = "profile_apps_by_developer"
    case profileDeleteAccount = "profile_delete_account"
    case profileRateApp = "profile_rate_app"
    case profileLogout = "profile_logout"
    case profileLogoutCancel = "profile_logout_cancel"
    case profileLogoutConfirm = "profile_logout_confirm"
    case profileDeleteCancel = "profile_delete_cancel"
    case profileDeleteConfirm = "profile_delete_confirm"
    case profileSuccessLogout = "profile_success_logout"
    case profileErrorLogout = "profile_error_logout"
    case profileSuccessDelete = "profile_success_delete"
    case profileErrorDelete = "profile_error_delete"
    case profilePopupLogoutCancelled = "profile_popup_logout_cancelled"
    case profilePopupDeleteCancelled = "profile_popup_delete_cancelled"
    case profilePopupCustomCancelled = "profile_popup_custom_cancelled"
    case profilePopupCustomConfirmed = "profile_popup_custom_confirmed"
    
    // Popup Strings
    case popupLogoutTitle = "popup_logout_title"
    case popupLogoutMessage = "popup_logout_message"
    case popupDeleteTitle = "popup_delete_title"
    case popupDeleteMessage = "popup_delete_message"
    
    case loading = "loading"
    
    case languageEnglish = "language_english"
    
    case buttonOpenTitle = "button_open_title"
    
    
    
}

final class LocalizationManager {
    
    static let shared = LocalizationManager()
    
    private init() {}
    
    
    // Localized string fetcher
    func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
     func localized(for key: LocalizationKeys) -> String {
        return localizedString(forKey: key.rawValue)
    }

    
}

extension String {
    static func localized(for key: LocalizationKeys) -> String {
        return LocalizationManager.shared.localizedString(forKey: key.rawValue)
    }
}
