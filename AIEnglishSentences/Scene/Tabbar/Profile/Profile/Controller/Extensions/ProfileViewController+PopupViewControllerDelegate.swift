//
//  ProfileViewController+PopupViewControllerDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import Foundation

extension ProfileViewController: PopupViewControllerDelegate {
    func popupDidCancel(popupType: PopupType) {
        switch popupType {
        case .logout:
            coordinator?.navigationController?.dismiss(animated: true)
        case .delete:
            coordinator?.navigationController?.dismiss(animated: true)
        case .custom:
            break
        }
    }

    func popupDidConfirm(popupType: PopupType) {
        switch popupType {
        case .logout:
            performLogout()
        case .delete:
            performDelete()
        case .custom:
            break
        }
    }
}
