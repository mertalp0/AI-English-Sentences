//
//  GenerateCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import BaseMVVMCKit
import UIKit
import RevenueCat
import RevenueCatUI

final class GenerateCoordinator: BaseCoordinator {

    var pageCellType: CellType?

    override func start() {

        let generateViewModel = GenerateViewModel()
        let generateVC = GenerateViewController(viewModel: generateViewModel)
        generateVC.pageCellType = pageCellType
        generateVC.coordinator = self
        push(generateVC)
    }

    func showResult(sentences: [Sentence]) {
        guard let navigationController = navigationController else {
            Logger.log("NavigationController is nil.", type: .error)
            return
        }
        let resultCoordinator = ResultCoordinator(navigationController: navigationController)
        resultCoordinator.sentences = sentences
        resultCoordinator.start()
    }

    func presentPaywall(with offering: Offering) {
        guard let navigationController = navigationController else {
            Logger.log("NavigationController is nil.", type: .error)
            return
        }
        let paywallVC = PaywallViewController(offering: offering)
        navigationController.present(paywallVC, animated: true)
      }

    func back() {
        guard let navigationController = navigationController else {
            Logger.log("NavigationController is nil.", type: .error)
            return
        }

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: false, animated: true)
        }
        pop()
    }
}
