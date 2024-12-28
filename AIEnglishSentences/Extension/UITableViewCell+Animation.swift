//
//  UITableViewCell+Animation.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit

extension UITableViewCell {
    
    func enablePressAnimation() {
        let touchDownGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePress(_:)))
        touchDownGesture.minimumPressDuration = 0
        touchDownGesture.cancelsTouchesInView = false

        self.addGestureRecognizer(touchDownGesture)
    }

    @objc private func handlePress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            animateScale(to: 0.95)
        case .ended, .cancelled:
            animateScale(to: 1.0)
        default:
            break
        }
    }
    
    private func animateScale(to scale: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: [.allowUserInteraction]) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}
