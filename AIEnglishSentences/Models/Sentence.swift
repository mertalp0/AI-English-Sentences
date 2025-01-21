//
//  Sentence.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import Foundation

struct Sentence: Codable {
    let id: String
    let sentence: String
    var favorite: Bool
    let category: String
    let promt: String
    let writingTone: String
    let writingStyle: String
    let createdAt: Date
}
