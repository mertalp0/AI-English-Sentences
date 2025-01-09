//
//  GenerateCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import BaseMVVMCKit
import UIKit

final class GenerateCoordinator: BaseCoordinator {
    
    var pageCellType: CellType?

    override func start() {
        
        let generateViewModel = GenerateViewModel()
        let generateVC = GenerateVC(viewModel: generateViewModel)
        generateVC.pageCellType = pageCellType
        generateVC.coordinator = self
        push(generateVC)
        
    }
    
    func showResult(sentences: [NewSentence]) {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }
        let resultCoordinator = ResultCoordinator(navigationController: navigationController)
        resultCoordinator.sentences = sentences
        resultCoordinator.start()

    }
    
    func showPaywall(){
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }
        let paywallCoordinator = PaywallCoordinator(navigationController: navigationController)
        paywallCoordinator.start()
    }
    
    func back() {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in ResultCoordinator")
        }

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: false, animated: true)
        }

        pop()
    }
}

