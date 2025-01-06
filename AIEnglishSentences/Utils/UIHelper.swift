//
//  UIHelper.swift
//  AIEnglishSentences
//
//  Created by mert alp on 21.12.2024.
//


import UIKit

struct UIHelper {
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
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
    
    static func resizedIcon(dynamicSize: CGFloat, weight: UIImage.SymbolWeight = .regular) -> UIImage.SymbolConfiguration {
        let screenHeight = UIScreen.main.bounds.height
        let baseHeight: CGFloat = AppConstants.baseDeviceHeight
        let scaledSize = dynamicSize * (screenHeight / baseHeight)
        
        return UIImage.SymbolConfiguration(pointSize: scaledSize, weight: weight)
    }
    
    static func dynamicFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let screenHeight = UIScreen.main.bounds.height
        let baseHeight: CGFloat = AppConstants.baseDeviceHeight
        let scaledSize = size * (screenHeight / baseHeight)
        return UIFont.systemFont(ofSize: scaledSize, weight: weight)
    }
}
