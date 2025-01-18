//
//  HistoryViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit

final class HistoryViewModel: BaseViewModel {
    
    private let userService = UserService.shared
    private let authService: AuthService = AuthServiceImpl.shared
    private let generateService = GenerateService.shared
    
    func fetchSentences(completion: @escaping (Bool) -> Void) {
        startLoading()
        
        guard let userId = authService.getCurrentUserId() else {
            handleFetchError(message: .localized(for: .historyFetchErrorUserNotLoggedIn))
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
    
    private func fetchSentencesWithUser(for generateIds: [String], completion: @escaping (Bool) -> Void) {
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
    
    func addFavoriteSentence(sentence: Sentence, completion: @escaping (Bool) -> Void) {
        startLoading()
        
        generateService.addFavoriteSentence(sentence: sentence) { [weak self] result in
            switch result {
            case .success(let updatedSentence):
                SentenceManager.shared.updateSentence(
                    updatedSentence,
                    at: SentenceManager.shared.sentences.firstIndex(where: { $0.id == updatedSentence.id })!
                )
                completion(true)
                print("\(updatedSentence.sentence) was added to favorites.")
            case .failure(let error):
                self?.handleError(message: error.localizedDescription)
                completion(false)
                print("Failed to add to favorites: \(error.localizedDescription)")
            }
            self?.stopLoading()
        }
    }
    
    func deleteFavoriteSentence(sentence: Sentence, completion: @escaping (Bool) -> Void) {
        startLoading()
        
        generateService.deleteFavoriteSentence(sentence: sentence) { [weak self] result in
            switch result {
            case .success(let updatedSentence):
                SentenceManager.shared.updateSentence(
                    updatedSentence,
                    at: SentenceManager.shared.sentences.firstIndex(where: { $0.id == updatedSentence.id })!
                )
                completion(true)
                print("\(updatedSentence.sentence) was removed from favorites.")
            case .failure(let error):
                self?.handleError(message: error.localizedDescription)
                completion(false)
                print("Failed to remove from favorites: \(error.localizedDescription)")
            }
            self?.stopLoading()
        }
    }
    
    func deleteSentence(sentence: Sentence, completion: @escaping (Bool) -> Void) {
        startLoading()
        
        generateService.deleteSentence(sentence: sentence) { [weak self] result in
            switch result {
            case .success:
                if let index = SentenceManager.shared.sentences.firstIndex(where: { $0.id == sentence.id }) {
                    SentenceManager.shared.removeSentence(at: index)
                    print("\(sentence.sentence) was successfully deleted.")
                    
                    guard let userId = self?.authService.getCurrentUserId() else {
                        print("Failed to get user ID.")
                        completion(false)
                        return
                    }
                    
                    self?.userService.removeGenerateIdFromUser(userId: userId, generateId: sentence.id) { result in
                        switch result {
                        case .success:
                            print("\(sentence.id) was successfully removed from the user.")
                            completion(true)
                        case .failure(let error):
                            self?.handleError(message: error.localizedDescription)
                            print("Failed to remove generateId from user: \(error.localizedDescription)")
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
