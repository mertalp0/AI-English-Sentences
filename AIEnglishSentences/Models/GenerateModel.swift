//
//  GenerateModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import Foundation
import FirebaseFirestore

struct GenerateModel: Codable {
    let id: String?
    let words: String
    let sentences: [String]
}
