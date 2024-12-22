//
//  GenerateSentenceViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit
import Foundation

final class GenerateSentenceViewModel: BaseViewModel{

    let openAIService = OpenAIService()

    let inputWords = "FOOTBALL, Computer, Player"
    let maxWords = 15
    let sentenceCount = 1
    
    func generateSentences(completion: @escaping(Result<GenerateModel,Error>)->Void){
        startLoading()
        
        openAIService.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount) { result in
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
