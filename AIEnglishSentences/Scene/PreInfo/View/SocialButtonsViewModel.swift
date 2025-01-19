//
//  SocialButtonsCreate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//

import Foundation

final class SocialButtonsViewModel {

    // MARK: - Properties
    var actionText: String
    var actionHighlightedText: String
    var googleButtonTitle: String
    var appleButtonTitle: String

    // MARK: - Callbacks
    var onGoogleButtonTapped: (() -> Void)?
    var onAppleButtonTapped: (() -> Void)?
    var onActionLabelTapped: (() -> Void)?

    // MARK: - Initialization
    init(
        actionText: String = "",
        actionHighlightedText: String = "",
        googleButtonTitle: String = "",
        appleButtonTitle: String = ""
    ) {
        self.actionText = actionText
        self.actionHighlightedText = actionHighlightedText
        self.googleButtonTitle = googleButtonTitle
        self.appleButtonTitle = appleButtonTitle
    }

    // MARK: - Actions
    func handleGoogleButtonTapped() {
        onGoogleButtonTapped?()
    }

    func handleAppleButtonTapped() {
        onAppleButtonTapped?()
    }

    func handleActionLabelTapped() {
        onActionLabelTapped?()
    }
}
