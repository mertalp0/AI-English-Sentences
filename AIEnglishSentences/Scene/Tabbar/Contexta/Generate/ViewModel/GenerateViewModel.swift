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

  
    
    func generateSentences (inputWords: String, maxWords: Int, sentenceCount: Int, category: String, writingTone: String, writingStyle: String , completion: @escaping(Result<[NewSentence],Error>)->Void){
        
        if inputWords.isEmpty {
            handleError(message: "Please provide some input words to generate sentences.")
            return
        }
        startLoading()

        openAIService.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount, category: category, writingTone: writingTone, writingStyle: writingStyle) { result in
            
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
