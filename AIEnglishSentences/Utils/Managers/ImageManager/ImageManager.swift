//
//  ImageManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 17.12.2024.
//

import UIKit

final class ImageManager {
    static let shared = ImageManager()

    private init() {}

    func getIcon(named name: AppIcons) -> UIImage? {
        return UIImage(systemName: name.rawValue)
    }

    func getImage(for image: AppImages) -> UIImage? {
        return UIImage(named: image.rawValue)
    }
}
