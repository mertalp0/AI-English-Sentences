//
//  PaywallCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 7.01.2025.
//

import BaseMVVMCKit

final class PaywallCoordinator: BaseCoordinator {
    
    override func start() {
        let paywallViewModel = PaywallViewModel()
        let paywallVC = PaywallVC(viewModel: paywallViewModel)
        paywallVC.coordinator = self
        
        navigationController?.present(paywallVC, animated: true)
    }
    
    func back(){
        navigationController?.dismiss(animated: true)
    }
}
