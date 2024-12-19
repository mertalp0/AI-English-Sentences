//
//  UserModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable {
    @DocumentID var id: String? 
    let name: String
    let email: String
    let createdAt: Date
    var generate: [String]
}
