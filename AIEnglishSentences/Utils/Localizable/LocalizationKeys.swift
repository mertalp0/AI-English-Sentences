//
//  LocalizationKeys.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.01.2025.
//

// MARK: - LocalizationKeys
enum LocalizationKeys: String {
    // MARK: - Shared Strings
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

    // MARK: - InfoCV Strings
    case infoSubTitle = "info_subtitle"

    // MARK: - LoginVC Strings
    case loginTitle = "login_title"
    case loginSubtitle = "login_subtitle"
    case forgotPassword = "forgot_password"

    // MARK: - RegisterVC Strings
    case createAccountTitle = "create_account_title"
    case registerSubtitle = "register_subtitle"
    case namePlaceholder = "name_placeholder"
    case nameTitle = "name_title"
    case alreadyHaveAccount = "already_have_account"
    case loginHighlighted = "login_highlighted"
    case validationName = "validation_name"

    // MARK: - Dashboard Strings
    case tabBarHistory = "tab_bar_history"
    case tabBarGenerate = "tab_bar_generate"
    case tabBarProfile = "tab_bar_profile"

    // MARK: - History Strings
    case historySegmentAll = "history_segment_all"
    case historySegmentFavourites = "history_segment_favourites"

    // MARK: - Empty State
    case historyEmptyAllTitle = "history_empty_all_title"
    case historyEmptyAllDescription = "history_empty_all_description"
    case historyEmptyFavouritesTitle = "history_empty_favourites_title"
    case historyEmptyFavouritesDescription = "history_empty_favourites_description"

    // MARK: - Toast Messages
    case historyCopiedToClipboard = "history_copied_to_clipboard"

    // MARK: - Delete Alert
    case historyDeleteAlertTitle = "history_delete_alert_title"
    case historyDeleteAlertMessage = "history_delete_alert_message"
    case historyDeleteAlertCancel = "history_delete_alert_cancel"
    case historyDeleteAlertConfirm = "history_delete_alert_confirm"
    case historyFetchErrorUserNotLoggedIn = "historyFetchErrorUserNotLoggedIn"

    // MARK: - ContextaVC Strings
    case contextaSubtitle = "contextaSubtitle"
    case contextaCategoriesTitle = "contextaCategoriesTitle"

    // MARK: - CategoryCell LocalizationKeys
    case categoryProfessionalTitle = "category_professional_title"
    case categoryProfessionalDescription = "category_professional_description"
    case categoryPersonalTitle = "category_personal_title"
    case categoryPersonalDescription = "category_personal_description"
    case categoryEducationalTitle = "category_educational_title"
    case categoryEducationalDescription = "category_educational_description"

    // MARK: - Writing Tone Keys
    case toneFormal = "tone_formal"
    case toneFriendly = "tone_friendly"
    case toneCasual = "tone_casual"
    case toneInspirational = "tone_inspirational"
    case toneHumorous = "tone_humorous"

    // MARK: - Writing Style Keys
    case stylePersuasive = "style_persuasive"
    case styleNarrative = "style_narrative"
    case styleDescriptive = "style_descriptive"
    case styleExplanatory = "style_explanatory"
    case styleCreative = "style_creative"

    // MARK: - GenerateVC Keys
    case generateTitle = "generate_title"
    case writingToneTitle = "writing_tone_title"
    case writingStyleTitle = "writing_style_title"

    // MARK: - CountSelectorView Keys
    case sentenceCountTitle = "sentence_count_title"
    case maxWordCountTitle = "max_word_count_title"

    // MARK: - GenerateButton Keys
    case generateButtonTitle = "generate_button_title"

    // MARK: - GenerateLoadingView Keys
    case generateLoadingTitle = "generate_loading_title"
    case generateLoadingDescription = "generate_loading_description"

    // MARK: - GenerateTextView Keys
    case generateTextViewPlaceholder = "generate_textview_placeholder"

    // MARK: - GenerateViewModel Strings
    case generateInputError = "generate_input_error"

    // MARK: - ResultVC Strings
    case resultSuccessTitle = "result_success_title"
    case resultSuccessRegistrationMessage = "result_success_registration_message"
    case resultOkButton = "result_ok_button"
    case resultCopyToClipboard = "result_copy_to_clipboard"
    case resultSentenceRemovedSuccess = "result_sentence_removed_success"
    case resultSentenceRemovedError = "result_sentence_removed_error"
    case resultSentenceSavedSuccess = "result_sentence_saved_success"
    case resultSentenceSavedError = "result_sentence_saved_error"
    case sharedErrorMessage = "shared_error_message"

    // MARK: - ProfileVC Strings
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

    // MARK: - Popup Strings
    case popupLogoutTitle = "popup_logout_title"
    case popupLogoutMessage = "popup_logout_message"
    case popupDeleteTitle = "popup_delete_title"
    case popupDeleteMessage = "popup_delete_message"

    // MARK: - General Strings
    case loading = "loading"
    case languageEnglish = "language_english"
    case buttonOpenTitle = "button_open_title"

    // MARK: - Error Strings
    case validationRequiredField = "validation_required_field"
    case errorInvalidEmail = "error_invalid_email"
    case errorWrongPassword = "error_wrong_password"
    case errorUserNotFound = "error_user_not_found"
    case errorUserAlreadyExists = "error_user_already_exists"
    case errorWeakPassword = "error_weak_password"
    case errorNetwork = "error_network"
    case errorUnknown = "error_unknown"
    case errorUserNotLoggedIn = "error_user_not_logged_in"
    case male = "male"
    case female = "female"
    case preferNotToSay = "prefer_notto_say"
    case errorMissingDocument = "error_missing_document"
    case errorDecodingFailed = "error_decoding_failed"
    case errorDocumentAlreadyExists = "error_document_already_exists"

    // MARK: - Dashboard Strings
    case appBarHistory = "app_bar_history"
    case appBarGenerate = "app_bar_generate"
    case appBarProfile = "app_bar_profile"
    case appBarContexta = "app_bar_contexta"
    case appBarResult = "app_bar_result"
    case appBarPrivacyPolicy = "app_bar_privacy_policy"
    case appBarMyApps = "app_bar_my_apps"
    case appBarLanguages = "app_bar_languages"

    // MARK: - Firebase Errors
    case errorMissingFirebaseClientId = "error_missing_firebase_client_id"
    case errorSignInResultNil = "error_sign_in_result_nil"
    case errorFailedToFetchTokens = "error_failed_to_fetch_tokens"
}
