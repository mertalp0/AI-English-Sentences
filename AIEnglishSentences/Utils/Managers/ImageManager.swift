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
        case globe = "globe"
        case textMagnifyingGlass = "doc.text.magnifyingglass"
        case envelope = "envelope.fill"
        case appBadge = "app.badge.fill"
        case binCircle = "xmark.bin.circle.fill"
        case personCircle = "person.circle.fill"
        case squareAndPencil = "square.and.pencil"
        case checkmarkCircle = "checkmark.circle.fill"
        case eyeSlash = "eye.slash"
        case clock = "clock"
        case textBadgePlus = "text.badge.plus"
        case personCropCircle = "person.crop.circle"
        case playCircle = "play.circle"
        case stopCircle = "stop.circle"
        case star = "star"
        case starFill = "star.fill"
        case bookmark = "bookmark"
        case bookmarkFill = "bookmark.fill"
        case docOnDoc = "doc.on.doc"
        case chevronLeft = "chevron.left"
        case logout = "rectangle.portrait.and.arrow.right"
        case trash = "trash"
        case chevronDown = "chevron.down"
        case chevronRight = "chevron.right"
    }
    
    func getIcon(named name: AppIcons) -> UIImage? {
        return UIImage(systemName: name.rawValue)
    }
    
    enum AppImages: String {
        case google = "google_icon"
        case apple = "apple_icon"
        case aiLexText = "ai_lex_text"
        case backgroundImage = "background_image"
        case historyAllEmpty = "history_all_empty_image"
        case historyFavoritesEmpty = "history_favorites_empty_image"
        case educational = "icon_educational"
        case personal = "icon_personal"
        case professional = "icon_professional"
        case iqTestLogo = "iq_test_logo"
        case loadingImage = "loading_image"
        case wandAndStars = "wand.and.stars"
        case appIcon = "app_icon_ailex"
        
    }
    
    func getImage(for image: AppImages) -> UIImage? {
        return UIImage(named: image.rawValue)
    }
}

