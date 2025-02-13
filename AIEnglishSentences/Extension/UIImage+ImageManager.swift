//
//  UIImage+ImageManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 10.01.2025.
//

import UIKit

extension UIImage {
    static func appIcon(_ icon: AppIcons) -> UIImage? {
        return ImageManager.shared.getIcon(named: icon)
    }

    static func appImage(_ image: AppImages) -> UIImage? {
        return ImageManager.shared.getImage(for: image)
    }
}
