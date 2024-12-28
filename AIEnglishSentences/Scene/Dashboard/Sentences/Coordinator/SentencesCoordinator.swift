//
//  SentencesCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

import BaseMVVMCKit
import UIKit

final class SentencesCoordinator: BaseCoordinator {
    
    var sentences : [String]?
    
    init(navigationController: UINavigationController, sentences: [String]? = nil) {
        super.init(navigationController: navigationController)
        self.sentences = sentences
    }
    
    override func start() {

        let sentencesViewModel = SentencesViewModel()
        let sentencesVC = SentencesVC(viewModel: sentencesViewModel)
        sentencesVC.coordinator = self
        sentencesVC.sentences = self.sentences ?? []
        push(sentencesVC)
        
    }
    
    func back(){
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in ResultCoordinator")
        }

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: false, animated: true)
        }

        pop()
    }
    
}

