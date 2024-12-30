//
//  ResultViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//
import Foundation
import BaseMVVMCKit

final class ResultViewModel: BaseViewModel {
    
    private let generateService = GenerateService.shared
    private let authService = AuthService.shared
    private let userService = UserService.shared
    
  
    func saveSentence(sentence: NewSentence, completion: @escaping (Bool) -> Void) {
        startLoading()
        generateService.saveSentence(sentence: sentence) { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case .success(_):
                self.handleSentenceeSaveSuccess(sentence: sentence, completion: completion)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
                completion(false)
            }
        }
   
    }
    
    private func handleSentenceeSaveSuccess(sentence: NewSentence, completion: @escaping (Bool) -> Void) {
        guard let userId = authService.getCurrentUserId() else {
            handleError(message: "An error occurred")
            completion(false)
            return
        }

        userService.addGenerateIdToUser(userId: userId, generateId: sentence.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                SentenceManager.shared.addSentence(sentence)
                completion(true)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
                completion(false)
            }
        }
    }
}
