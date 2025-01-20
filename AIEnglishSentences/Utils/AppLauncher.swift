//
//  AppLauncher.swift
//  AIEnglishSentences
//
//  Created by mert alp on 26.12.2024.
//

import Foundation
import UIKit

final class AppLauncher {
    static let shared = AppLauncher()

    private init() {}

    func openApp(
        appURLScheme: String,
        appStoreURL: String,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard let appURL = URL(string: appURLScheme) else {
            completion?(false)
            return
        }

        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:]) { success in
                completion?(success)
            }
        } else if let appStoreURL = URL(string: appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:]) { success in
                completion?(success)
            }
        } else {
            completion?(false)
        }
    }
}
