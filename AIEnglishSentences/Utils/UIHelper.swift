//
//  UIHelper.swift
//  AIEnglishSentences
//
//  Created by mert alp on 21.12.2024.
//

import UIKit

struct UIHelper {
    // MARK: - Status Bar
    static var statusBarHeight: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let statusBarManager = windowScene.statusBarManager else {
            return 0
        }
        return statusBarManager.statusBarFrame.height
    }

    // MARK: - Dynamic Size Calculations
    static func dynamicHeight(_ baseHeight: CGFloat) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let baseDeviceHeight: CGFloat = AppConstants.baseDeviceHeight
        return baseHeight * (screenHeight / baseDeviceHeight)
    }

    static func dynamicWidth(_ baseWidth: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseDeviceWidth: CGFloat = AppConstants.baseDeviceWidth
        return baseWidth * (screenWidth / baseDeviceWidth)
    }

    // MARK: - Resized Icon
    static func resizedIcon(dynamicSize: CGFloat, weight: UIImage.SymbolWeight = .regular) -> UIImage.SymbolConfiguration {
        let screenHeight = UIScreen.main.bounds.height
        let baseHeight: CGFloat = AppConstants.baseDeviceHeight
        let scaledSize = dynamicSize * (screenHeight / baseHeight)

        return UIImage.SymbolConfiguration(pointSize: scaledSize, weight: weight)
    }

    // MARK: - Dynamic Font
    static func dynamicFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let screenHeight = UIScreen.main.bounds.height
        let baseHeight: CGFloat = AppConstants.baseDeviceHeight
        let scaledSize = size * (screenHeight / baseHeight)
        return UIFont.systemFont(ofSize: scaledSize, weight: weight)
    }
}
