//
//  LanguageSelectionVC+AppBarDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

// MARK: - AppBarDelegate
extension LanguageSelectionViewController: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.back()
    }
}
