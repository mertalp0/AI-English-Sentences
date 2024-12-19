//
//  GenerateSentenceViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit

final class GenerateSentenceViewModel: BaseViewModel{

    let openAIService = OpenAIService()

    let inputWords = "FOOTBALL, Computer, Player"
    let maxWords = 15
    let sentenceCount = 5
    
    func generateSentences(completion: @escaping(Bool)->Void){
        startLoading()
        openAIService.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount) { result in
            switch result {
            case .success(let sentences):
                self.stopLoading()
                print("Generated Sentences:")
                sentences.forEach { print($0) }
                completion(true)
            case .failure(let error):
                self.stopLoading()
                self.handleError(message: error.localizedDescription)
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
        
    }
}
