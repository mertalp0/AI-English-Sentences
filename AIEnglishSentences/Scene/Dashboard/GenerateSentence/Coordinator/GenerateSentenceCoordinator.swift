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
    
    func showResult(generateModel: GenerateModel) {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }
        let resultCoordinator = ResultCoordinator(navigationController: navigationController)
        resultCoordinator.generateModel = generateModel
        resultCoordinator.start()

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: true, animated: false)
        }
    }

}

