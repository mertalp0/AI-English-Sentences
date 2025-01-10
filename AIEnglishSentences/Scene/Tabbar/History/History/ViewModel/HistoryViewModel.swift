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
    
    func addFavoriteSentence(sentence: Sentence, completion: @escaping (Bool) -> Void) {
        startLoading()
        
        generateService.addFavoriteSentence(sentence: sentence) { [weak self] result in
            switch result {
            case .success(let updatedSentence):
                SentenceManager.shared.updateSentence(updatedSentence, at: SentenceManager.shared.sentences.firstIndex(where: { $0.id == updatedSentence.id })!)
                completion(true)
                print("\(updatedSentence.sentence) favorilere eklendi.")
            case .failure(let error):
                self?.handleError(message: error.localizedDescription)
                completion(false)
                print("Favori ekleme başarısız: \(error.localizedDescription)")
            }
            self?.stopLoading()
        }
    }
    
    func deleteFavoriteSentence(sentence: Sentence, completion: @escaping (Bool) -> Void) {
        startLoading()
        
        generateService.deleteFavoriteSentence(sentence: sentence) { [weak self] result in
            switch result {
            case .success(let updatedSentence):
                SentenceManager.shared.updateSentence(updatedSentence, at: SentenceManager.shared.sentences.firstIndex(where: { $0.id == updatedSentence.id })!)
                completion(true)
                print("\(updatedSentence.sentence) favorilerden çıkarıldı.")
            case .failure(let error):
                self?.handleError(message: error.localizedDescription)
                completion(false)
                print("Favorilerden çıkarma başarısız: \(error.localizedDescription)")
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
                    print("\(sentence.sentence) başarıyla silindi.")
                    
                    // Kullanıcıdan ilgili generateId'yi kaldır
                    guard let userId = self?.authService.getCurrentUserId() else {
                        print("Kullanıcı ID'si alınamadı.")
                        completion(false)
                        return
                    }
                    
                    self?.userService.removeGenerateIdFromUser(userId: userId, generateId: sentence.id) { result in
                        switch result {
                        case .success:
                            print("\(sentence.id) kullanıcıdan başarıyla kaldırıldı.")
                            completion(true)
                        case .failure(let error):
                            self?.handleError(message: error.localizedDescription)
                            print("Kullanıcıdan generateId kaldırma başarısız: \(error.localizedDescription)")
                            completion(false)
                        }
                    }
                } else {
                    print("Cümle yerel listede bulunamadı.")
                    completion(false)
                }
            case .failure(let error):
                self?.handleError(message: error.localizedDescription)
                print("Cümle silme başarısız: \(error.localizedDescription)")
                completion(false)
            }
            self?.stopLoading()
        }
    }
}
