//
//  ProfileViewController+Actions.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import Foundation

// MARK: - Actions
extension ProfileViewController {

    func changeLanguage() {
        coordinator?.showLanguagePage()
    }

    func rateApp() {
        viewModel.rateAppInAppStore()
    }

    func openPrivacyPolicy() {
        coordinator?.showPrivacyPolicy()
    }

    func openAppsByDeveloper() {
        coordinator?.showApps()
    }

    func inviteFriends() {
        coordinator?.shareApp()
    }

    func deleteAccount() {
        let deletePopup = PopupViewController(
            popupType: .delete,
            icon: .appIcon(.trash),
            cancelText: .localized(for: .profileDeleteCancel),
            confirmText: .localized(for: .profileDeleteConfirm)
        )
        deletePopup.delegate = self
        deletePopup.modalPresentationStyle = .overFullScreen
        deletePopup.modalTransitionStyle = .crossDissolve
        present(deletePopup, animated: true)
    }

    @objc func onLogoutButtonPressed() {

        let logoutPopup = PopupViewController(
            popupType: .logout,
            icon: .appIcon(.logout),
            cancelText: .localized(for: .profileLogoutCancel),
            confirmText: .localized(for: .profileLogoutConfirm)
        )
        logoutPopup.delegate = self
        logoutPopup.modalPresentationStyle = .overFullScreen
        logoutPopup.modalTransitionStyle = .crossDissolve
        present(logoutPopup, animated: true)
    }

    func performLogout() {
        tabBarController?.tabBar.isUserInteractionEnabled = false
        viewModel.logout { isSuccess in
            if isSuccess {
                self.coordinator?.showInfo()
            } else {
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
            }
        }
    }

    func performDelete() {
        tabBarController?.tabBar.isUserInteractionEnabled = false
        viewModel.deleteAccount { isSuccess in
            if isSuccess {
                self.coordinator?.showInfo()
            } else {
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
            }
        }
    }
}
