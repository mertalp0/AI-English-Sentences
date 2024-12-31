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
}

