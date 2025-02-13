//
//  ResultCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import BaseMVVMCKit
import UIKit

final class ResultCoordinator: BaseCoordinator {

    var sentences: [Sentence]?

    init(navigationController: UINavigationController, sentences: [Sentence]? = nil) {
        super.init(navigationController: navigationController)
        self.sentences = sentences
    }

    override func start() {
        let resultViewModel = ResultViewModel()
        let resultVC = ResultViewController(viewModel: resultViewModel)
        resultVC.coordinator = self
        resultVC.sentences = sentences
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
