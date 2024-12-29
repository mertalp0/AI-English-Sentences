//
//  ProfileViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import Foundation
import BaseMVVMCKit

final class ProfileViewModel: BaseViewModel {
    
    private let authService = AuthService.shared
    private let appLauncher = AppLauncher.shared
    
    func logout(completion: @escaping (Bool) -> Void) {
        startLoading()
        authService.logout { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                switch result {
                case .success:
                    self.stopLoading()
                    completion(true)
                case .failure(let error):
                    self.stopLoading()
                    self.handleError(message: error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    func openIqTestApp(completion: @escaping (Bool) -> Void) {
        let appURLScheme = AppConstants.URLs.iqTestAppURLScheme
        let appStoreURL = AppConstants.URLs.iqTestAppStoreURL
        
        appLauncher.openApp(appURLScheme: appURLScheme, appStoreURL: appStoreURL, completion: completion)
    }
}
