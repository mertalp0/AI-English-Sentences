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
    
    func fetchSentences(completion: @escaping(Bool)->Void){
        self.startLoading()
        
        guard let userId = authService.getCurrentUserId() else {
            stopLoading()
            handleError(message: "An error occurred")
            return
        }
        
        userService.getUser(by: userId) { result in
            
            switch result {
            case .success(let user):
                self.generateService.getGenerates(for: user.generate) { result in
                    switch result{
                    case .success(let generateModelList):
                        self.stopLoading()
                        GenerateManager.shared.generateModels = generateModelList
                        completion(true)
                    case .failure(let error):
                        self.stopLoading()
                        self.handleError(message: error.localizedDescription)
                        completion(false)
                    }
                }
            case .failure(let error):
                self.stopLoading()
                self.handleError(message: error.localizedDescription)
                completion(false)
            }
        }
        
        
    }
}
