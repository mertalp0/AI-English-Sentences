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
    
    func saveGenerateModel(generateModel: GenerateModel, completion: @escaping (Bool) -> Void) {
        startLoading()
        generateService.saveGenerate(generate: generateModel) { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case .success(_):
                self.handleGenerateSaveSuccess(generate: generateModel, completion: completion)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
                completion(false)
            }
        }
    }
    
    private func handleGenerateSaveSuccess(generate: GenerateModel, completion: @escaping (Bool) -> Void) {
        guard let userId = authService.getCurrentUserId() else {
            handleError(message: "An error occurred")
            completion(false)
            return
        }
        guard let generateId = generate.id else {
            handleError(message: "An error occurred")
            completion(false)
            return
        }
        
        userService.addGenerateIdToUser(userId: userId, generateId: generateId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                GenerateManager.shared.addGenerateModel(generate)
                completion(true)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
                completion(false)
            }
        }
    }
}
