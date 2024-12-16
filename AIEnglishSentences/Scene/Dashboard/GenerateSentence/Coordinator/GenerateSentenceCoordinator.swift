//
//  GenerateSentenceCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit
import UIKit

final class GenerateSentenceCoordinator: BaseCoordinator {
    
    override func start() {
        
        let generateSentenceViewModel = GenerateSentenceViewModel()
        let generateSentenceVC = GenerateSentenceVC(viewModel: generateSentenceViewModel)
        generateSentenceVC.coordinator = self
        push(generateSentenceVC)
        
    }
}

