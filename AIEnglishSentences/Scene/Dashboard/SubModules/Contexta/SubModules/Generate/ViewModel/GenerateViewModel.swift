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
    
    func generateSentences(completion: @escaping(Result<GenerateModel,Error>)->Void){
        startLoading()
        
        openAIService.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount) { result in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                switch result {
                case .success(let sentences):
                    self.stopLoading()
                    print("Generated Sentences:")
                    sentences.forEach { print($0) }
                    let generateModel = GenerateModel(id: UUID().uuidString, words: self.inputWords, sentences: sentences)
                    completion(.success(generateModel))
                    
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
