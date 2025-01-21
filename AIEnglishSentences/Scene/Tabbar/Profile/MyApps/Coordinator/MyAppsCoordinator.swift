//
//  MyAppsCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import BaseMVVMCKit

final class MyAppsCoordinator: BaseCoordinator {

    override func start() {
        let myAppsViewModel = MyAppsViewModel()
        let myAppsVC = MyAppsViewController(viewModel: myAppsViewModel)
        myAppsVC.coordinator = self
        push(myAppsVC)
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
