//
//  ResultCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import BaseMVVMCKit
import UIKit

final class ResultCoordinator: BaseCoordinator {
    
    override func start() {
        
        let resultViewModel = ResultViewModel()
        let resultVC = ResultVC(viewModel: resultViewModel)
        resultVC.coordinator = self
        push(resultVC)
        
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

