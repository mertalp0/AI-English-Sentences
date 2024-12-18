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
    
    func generateSentences(){
      
        openAIService.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount) { result in
            switch result {
            case .success(let sentences):
                print("Generated Sentences:")
                sentences.forEach { print($0) }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
}
