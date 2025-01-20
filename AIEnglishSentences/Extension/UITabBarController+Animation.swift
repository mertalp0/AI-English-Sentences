//
//  UITabBarController+Animation.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import UIKit

extension UITabBarController {
    func setTabBar(
        hidden: Bool,
        animated: Bool = true,
        duration: TimeInterval = 0.2
    ) {
        let tabBarFrame = tabBar.frame
        let offset = hidden ? tabBarFrame.height : -tabBarFrame.height

        UIView.animate(
                withDuration: animated ? duration : 0,
                       delay: 0,
                       options: [.curveEaseInOut, .beginFromCurrentState],
                       animations: {
            self.tabBar.frame = tabBarFrame.offsetBy(dx: 0, dy: offset)
            self.tabBar.alpha = hidden ? 0 : 1
        })
    }
}
