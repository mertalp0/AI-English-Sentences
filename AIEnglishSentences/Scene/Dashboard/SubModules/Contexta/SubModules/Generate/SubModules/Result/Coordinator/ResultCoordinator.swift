//
//  ResultCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import BaseMVVMCKit
import UIKit

final class ResultCoordinator: BaseCoordinator {
    
    var generateModel : GenerateModel?
    
    init(navigationController: UINavigationController, generateModel: GenerateModel? = nil) {
        super.init(navigationController: navigationController)
        self.generateModel = generateModel
    }
    
    override func start() {
        
        let resultViewModel = ResultViewModel()
        let resultVC = ResultVC(viewModel: resultViewModel)
        resultVC.coordinator = self
        resultVC.generateModel = generateModel
        push(resultVC)
        
    }
    
    func showRoot() {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in ResultCoordinator")
        }

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: false, animated: true)
        }

        popToRoot()
    }

}

