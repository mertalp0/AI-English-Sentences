//
//  CGFloat+Dynamic.swift
//  AIEnglishSentences
//
//  Created by mert alp on 5.01.2025.
//

import UIKit

extension CGFloat {
    static func dynamicHeight(_ value: CGFloat) -> CGFloat {
        return UIHelper.dynamicHeight(value)
    }
    
    static func dynamicWidth(_ value: CGFloat) -> CGFloat {
        return UIHelper.dynamicWidth(value)
    }
}
