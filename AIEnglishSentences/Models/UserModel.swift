//
//  UserModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation
import FirebaseCore

struct UserModel: Codable {
    let id: String
    var name: String
    let email: String
    let gender: String
    let createdAt: Date
    var generate: [String]

    func toFirestore() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "gender": gender,
            "createdAt": createdAt,
            "generate": generate
        ]
    }

    static func fromFirestore(data: [String: Any]) -> UserModel? {
        guard
            let id = data["id"] as? String,
            let name = data["name"] as? String,
            let email = data["email"] as? String,
            let gender = data["gender"] as? String,
            let createdAt = (data["createdAt"] as? Timestamp)?.dateValue(),
            let generate = data["generate"] as? [String]
        else {
            return nil
        }

        return UserModel(
            id: id,
            name: name,
            email: email,
            gender: gender,
            createdAt: createdAt,
            generate: generate
        )
    }
}

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case preferNotToSay = "PreferNottoSay"
}
