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
    private let authService : AuthService = AuthServiceImpl.shared
    private let userService = UserService.shared
    
    func saveSentence(sentence: Sentence, completion: @escaping (Bool) -> Void) {
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
    
    private func handleSentenceeSaveSuccess(sentence: Sentence, completion: @escaping (Bool) -> Void) {
        guard let userId = authService.getCurrentUserId() else {
            handleError(message: .localized(for: .sharedErrorMessage))
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
    
    func deleteSentence(sentence: Sentence, completion: @escaping (Bool) -> Void) {
        startLoading()
        
        generateService.deleteSentence(sentence: sentence) { [weak self] result in
            switch result {
            case .success:
                if let index = SentenceManager.shared.sentences.firstIndex(where: { $0.id == sentence.id }) {
                    
                    print("\(sentence.sentence) successfully deleted.")
                    guard let userId = self?.authService.getCurrentUserId() else {
                        print("Failed to retrieve user ID.")
                        completion(false)
                        return
                    }
                    
                    self?.userService.removeGenerateIdFromUser(userId: userId, generateId: sentence.id) { result in
                        switch result {
                        case .success:
                            SentenceManager.shared.removeSentence(at: index)
                            print("\(sentence.id) successfully removed from user.")
                            completion(true)
                        case .failure(let error):
                            self?.handleError(message: error.localizedDescription)
                            print("Failed to remove generate ID from user: \(error.localizedDescription)")
                            completion(false)
                        }
                    }
                } else {
                    print("Sentence not found in the local list.")
                    completion(false)
                }
            case .failure(let error):
                self?.handleError(message: error.localizedDescription)
                print("Failed to delete sentence: \(error.localizedDescription)")
                completion(false)
            }
            self?.stopLoading()
        }
    }
}

