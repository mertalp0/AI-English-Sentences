//
//  ResultVC+AppBarDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

extension ResultViewController: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.showRoot()
    }
}
