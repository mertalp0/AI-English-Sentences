//
//  HistoryViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit

final class HistoryViewModel: BaseViewModel {
    
    private let userService = UserService.shared
    private let authService = AuthService.shared
    private let generateService = GenerateService.shared
    
    func fetchSentences() {
        startLoading()
        
        guard let userId = authService.getCurrentUserId() else {
            handleFetchError(message: "User not logged in")
            return
        }
        
        userService.getUser(by: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.fetchGenerates(for: user.generate)
            case .failure(let error):
                self?.handleFetchError(message: error.localizedDescription)
            }
        }
    }
    
    private func fetchGenerates(for generateIds: [String]) {
        generateService.getGenerates(for: generateIds) { [weak self] result in
            switch result {
            case .success(let generateModelList):
                GenerateManager.shared.generateModels = generateModelList
                self?.stopLoading()
            case .failure(let error):
                self?.handleFetchError(message: error.localizedDescription)
            }
        }
    }
    
    private func handleFetchError(message: String) {
        stopLoading()
        handleError(message: message)
    }
}
