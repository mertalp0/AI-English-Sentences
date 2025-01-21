//
//  AppConstants.swift
//  AIEnglishSentences
//
//  Created by mert alp on 26.12.2024.
//

import UIKit

struct AppConstants {

    struct URLs {
        static let appUrl = "https://apps.apple.com/tr/app/ailex/id6740177658?l=tr"
        static let iqTestAppURLScheme = "iqtest://"
        static let iqTestAppStoreURL = "https://apps.apple.com/tr/app/iq-test/id6670162878?l=tr"
        static let privacyPolicyURL = "https://ailex4.wordpress.com/?_gl=1*1k9njbl*_gcl_au*NzUzNjE3NTA1LjE3MzYxOTI4Mjk."
    }

    static let myApps: [AppModel] = [
        AppModel(appIcon: UIImage.appImage(.iqTestLogo) ?? UIImage(), appName: "IQ Test", appDescription: "The IQ Test application allows you to effectively test your mental skills and quickly evaluate your progress. Complete your tests in just 5 minutes and discover your IQ level while tracking your improvement."),
        AppModel(appIcon: UIImage.appImage(.appIcon) ?? UIImage(), appName: "AILex", appDescription: "AILex helps you improve your English skills by generating sentences using AI-provided words. Practice listening to these sentences and enhance your vocabulary and comprehension. In just a few minutes a day, boost your confidence in English while tracking your progress and mastering the language.")
    ]

    static let baseDeviceHeight: CGFloat = 812.0
    static let baseDeviceWidth: CGFloat = 375.0
}
