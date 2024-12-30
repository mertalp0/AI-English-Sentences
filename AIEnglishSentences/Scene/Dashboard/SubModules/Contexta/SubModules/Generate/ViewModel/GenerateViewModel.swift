//
//  GenerateViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import BaseMVVMCKit
import Foundation

final class GenerateViewModel: BaseViewModel {
 
    let openAIService = OpenAIService()

    let inputWords = "Color Text"
    let maxWords = 10
    let sentenceCount = 2
    
    func generateSentences(completion: @escaping(Result<[NewSentence],Error>)->Void){
        startLoading()
        
        openAIService.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount) { result in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                switch result {
                case .success(let sentences):
                    self.stopLoading()
                    print("Generated Sentences:")
                    completion(.success(sentences))
                    
                case .failure(let error):
                    self.stopLoading()
                    self.handleError(message: error.localizedDescription)
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
    
}
