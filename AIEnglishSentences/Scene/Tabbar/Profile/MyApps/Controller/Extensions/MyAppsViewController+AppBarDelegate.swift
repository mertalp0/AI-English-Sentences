//
//  MyAppsViewController+AppBarDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

extension MyAppsViewController: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.back()
    }
}
