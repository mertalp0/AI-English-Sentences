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
}
