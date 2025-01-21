//
//  ProfileViewController+ProfileHeaderViewDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import Foundation

// MARK: - ProfileHeaderViewDelegate
extension ProfileViewController: ProfileHeaderViewDelegate {
    func didUpdateName(_ newName: String) {
        viewModel.updateUser(name: newName)
    }
}
