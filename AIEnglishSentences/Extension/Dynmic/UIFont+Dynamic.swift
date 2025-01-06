//
//  UIFont+Dynamic.swift
//  AIEnglishSentences
//
//  Created by mert alp on 5.01.2025.
//

import UIKit

extension UIFont {
    static func dynamicFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIHelper.dynamicFont(size: size, weight: weight)
    }
}
