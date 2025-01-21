//
//  CustomTabBarController+UITabBarControllerDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import Foundation
import UIKit

// MARK: - UITabBarControllerDelegate
extension DashboardController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let currentVC = selectedViewController else { return true }

        if let fromView = currentVC.view, let toView = viewController.view, fromView != toView {
            UIView.transition(
                from: fromView,
                to: toView,
                duration: 0.3,
                options: [.transitionCrossDissolve],
                completion: nil
            )
        }
        return true
    }
}
