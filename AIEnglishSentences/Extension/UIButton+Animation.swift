//
//  UIButton+Animation.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit

extension UIButton {
    func addPressAnimation() {
        addTarget(self, action: #selector(pressDown), for: .touchDown)
        addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func pressDown() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .allowUserInteraction) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc private func pressUp() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .allowUserInteraction) {
            self.transform = .identity
        }
    }
}
