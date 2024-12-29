//
//  UIViewController+KeyboardDismiss.swift
//  AIEnglishSentences
//
//  Created by mert alp on 23.12.2024.
//

import UIKit

extension UIViewController {
    func setupKeyboardDismissRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

