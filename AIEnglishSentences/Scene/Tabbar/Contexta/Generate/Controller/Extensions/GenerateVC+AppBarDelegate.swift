//
//  GenerateVC+AppBarDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

// MARK: - AppBarDelegate
extension GenerateViewController: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.back()
    }
}
