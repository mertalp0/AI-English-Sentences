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

