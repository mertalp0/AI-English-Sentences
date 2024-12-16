//
//  GenerateSentenceViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit

final class GenerateSentenceViewModel: BaseViewModel{
    
    func generateSentences(){
        startLoading()
        print("generating")
    }

}
