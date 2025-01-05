//
//  UIColor+Hex.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

//import UIKit
//
//// MARK: - UIColor Hex Extension
//extension UIColor {
//    convenience init(hex: String) {
//        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
//        
//        var rgb: UInt64 = 0
//        Scanner(string: hexSanitized).scanHexInt64(&rgb)
//        
//        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat(rgb & 0x0000FF) / 255.0
//        let alpha: CGFloat = hexSanitized.count == 8 ? CGFloat((rgb & 0xFF000000) >> 24) / 255.0 : 1.0
//        
//        self.init(red: red, green: green, blue: blue, alpha: alpha)
//    }
//}
