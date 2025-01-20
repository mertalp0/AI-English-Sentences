//
//  Alert+BaseVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.01.2025.
//

import BaseMVVMCKit
import UIKit

extension BaseViewController {

     func showSuccesAlert() {
        let alert = UIAlertController(
            title: .localized(for: .resultSuccessTitle),
            message: .localized(for: .resultSuccessRegistrationMessage),
            preferredStyle: .alert
        )
         let action = UIAlertAction(
            title: .localized(
                for: .resultOkButton
            ),
            style: .default,
            handler: nil
         )
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func showAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: .localized(for: .resultOkButton), style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
