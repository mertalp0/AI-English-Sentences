//
//  PrivacyPolicyViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.01.2025.
//

import BaseMVVMCKit
import Foundation

final class PrivacyPolicyViewModel: BaseViewModel {

    func getPrivacyPolicyURL() -> URL? {
        return URL(string: AppConstants.URLs.privacyPolicyURL)
    }
}
