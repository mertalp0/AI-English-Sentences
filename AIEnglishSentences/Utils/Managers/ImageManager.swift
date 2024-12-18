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
    
    enum AppIcons: String {
        case example = "example"
    }
   
    func getImage(named name: AppIcons) -> UIImage? {
        return UIImage(systemName: name.rawValue)
    }
    
    
    enum AppImages: String {
        case example = "example"
    }
    
    func getImage(for image: AppImages) -> UIImage? {
        return UIImage(named: image.rawValue)
    }
}

