//
//  GenerateSentenceCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit
import UIKit

final class ContextaCoordinator: BaseCoordinator {

    override func start() {

        let contextaViewModel = ContextaViewModel()
        let gcontextaVC = ContextaViewController(viewModel: contextaViewModel)
        gcontextaVC.coordinator = self
        push(gcontextaVC)
    }

    func showGenerate(for pageCellTpye: CellType) {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }

        let generateCoordinator = GenerateCoordinator(navigationController: navigationController)
        generateCoordinator.pageCellType = pageCellTpye
        generateCoordinator.start()

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: true, animated: false)
        }
    }
}
