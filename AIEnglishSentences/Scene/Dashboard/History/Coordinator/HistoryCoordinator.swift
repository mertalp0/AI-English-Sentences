//
//  HistoryCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit
import UIKit

final class HistoryCoordinator: BaseCoordinator {
    
    override func start() {
        
        let historyViewModel = HistoryViewModel()
        let historyVC = HistoryVC(viewModel: historyViewModel)
        historyVC.coordinator = self
        push(historyVC)
        
    }
    
    func showSentences(sentences: [String]){
       
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }
        
       let sentencesCoordinator = SentencesCoordinator(navigationController: navigationController)
       sentencesCoordinator.sentences = sentences
       sentencesCoordinator.start()
    
        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: true, animated: false)
        }
   }
}

