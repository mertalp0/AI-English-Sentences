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
        
    func fetchSentences(completion: @escaping(Bool)-> Void) {
        startLoading()
        
        guard let userId = authService.getCurrentUserId() else {
            handleFetchError(message: "User not logged in")
            return
        }
        
        userService.getUser(by: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.fetchSentencesWithUser(for: user.generate, completion: completion)
            case .failure(let error):
                completion(false)
                self?.handleFetchError(message: error.localizedDescription)
            }
        }
    }
    
    private func fetchSentencesWithUser(for generateIds: [String] , completion: @escaping (Bool)-> Void) {
        generateService.getGenerates(for: generateIds) { [weak self] result in
            switch result {
            case .success(let sentences):
                SentenceManager.shared.loadSentences(sentences)
                completion(true)
                self?.stopLoading()
            case .failure(let error):
                completion(false)
                self?.handleFetchError(message: error.localizedDescription)
            }
        }
    }
    
    private func handleFetchError(message: String) {
        stopLoading()
        handleError(message: message)
    }
}
