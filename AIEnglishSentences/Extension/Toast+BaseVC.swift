//
//  Toast+BaseVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//

import BaseMVVMCKit
import UIKit
import SnapKit

extension BaseViewController {
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        
        let toastContainer = UIView()
        toastContainer.backgroundColor = UIColor.systemGreen
        toastContainer.layer.cornerRadius = 8
        toastContainer.clipsToBounds = true
        
        toastContainer.addSubview(toastLabel)
        view.addSubview(toastContainer)
        
        toastLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        toastContainer.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.8)
        }
        
        toastContainer.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            toastContainer.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0
            }) { _ in
                toastContainer.removeFromSuperview()
            }
        }
    }
}
