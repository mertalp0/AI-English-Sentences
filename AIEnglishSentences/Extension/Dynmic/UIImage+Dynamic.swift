//
//  UIImage+Dynamic.swift
//  AIEnglishSentences
//
//  Created by mert alp on 6.01.2025.
//

import UIKit

extension UIImage {
    func resizedIcon(dynamicSize: CGFloat, weight: UIImage.SymbolWeight = .regular) -> UIImage? {
        let configuration = UIHelper.resizedIcon(dynamicSize: dynamicSize , weight: weight)
        return self.withConfiguration(configuration)
    }
}
