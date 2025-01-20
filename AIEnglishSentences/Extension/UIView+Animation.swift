//
//  UIView+Animation.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit

extension UIView {
    func animateBackgroundColor(
        to color: UIColor,
        duration: TimeInterval = 0.3
    ) {
        UIView.animate(
                withDuration: duration,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
            self.backgroundColor = color
        })
    }

    func animateScaleDown(
        duration: TimeInterval = 0.1,
        scale: CGFloat = 0.95
    ) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }

    func animateScaleUp(
        duration: TimeInterval = 0.1
    ) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = .identity
        })
    }
}
