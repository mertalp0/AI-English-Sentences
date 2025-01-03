//
//  UserModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable {
    let id: String
    var name: String
    let email: String
    let gender: String
    let createdAt: Date
    var generate: [String]
}
