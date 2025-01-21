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
    private let authService: AuthService = AuthServiceImpl.shared
    private let userService = UserService.shared

    // MARK: - Save Sentence
    func saveSentence(
        sentence: Sentence,
        completion: @escaping (Bool) -> Void
    ) {
        startLoading()
        generateService.saveSentence(sentence: sentence) { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case .success:
                self.handleSentenceeSaveSuccess(sentence: sentence, completion: completion)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
                completion(false)
            }
        }
    }

    // MARK: - Delete Sentence
    func deleteSentence(
        sentence: Sentence,
        completion: @escaping (Bool) -> Void
    ) {
        startLoading()
        generateService.deleteSentence(sentence: sentence) { [weak self] result in
            self?.handleDeleteResult(result: result, sentence: sentence, completion: completion)
        }
    }
}

// MARK: - Private Helpers
extension ResultViewModel {

    private func handleSentenceeSaveSuccess(
        sentence: Sentence,
        completion: @escaping (Bool) -> Void
    ) {
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

    private func handleDeleteResult(
        result: Result<Void, Error>,
        sentence: Sentence,
        completion: @escaping (Bool) -> Void
    ) {
        switch result {
        case .success:
            handleLocalSentenceDeletion(sentence: sentence, completion: completion)
        case .failure(let error):
            handleError(message: error.localizedDescription)
            Logger.log("Failed to delete sentence: \(error.localizedDescription)", type: .error)
            completion(false)
        }
        stopLoading()
    }

    private func handleLocalSentenceDeletion(
        sentence: Sentence,
        completion: @escaping (Bool) -> Void
    ) {
        guard let index = SentenceManager.shared.sentences.firstIndex(where: { $0.id == sentence.id }) else {
            Logger.log("Sentence not found in the local list.", type: .error)
            completion(false)
            return
        }

        Logger.log("\(sentence.sentence) successfully deleted.", type: .info)
        guard let userId = authService.getCurrentUserId() else {
            Logger.log("Failed to retrieve user ID.", type: .error)
            completion(false)
            return
        }

        userService.removeGenerateIdFromUser(
            userId: userId,
            generateId: sentence.id
        ) { [weak self] result in
            self?.handleUserServiceResult(result: result, index: index, sentenceId: sentence.id, completion: completion)
        }
    }

    private func handleUserServiceResult(
        result: Result<Void, Error>,
        index: Int,
        sentenceId: String,
        completion: @escaping (Bool) -> Void
    ) {
        switch result {
        case .success:
            SentenceManager.shared.removeSentence(at: index)
            Logger.log("\(sentenceId) successfully removed from user.", type: .info)
            completion(true)
        case .failure(let error):
            handleError(message: error.localizedDescription)
            Logger.log("Failed to remove generate ID from user: \(error.localizedDescription)", type: .error)
            completion(false)
        }
    }
}
