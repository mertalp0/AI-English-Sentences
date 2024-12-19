//
//  FirebaseRequest.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//


import Foundation

struct FirebaseRequest {
    let collection: String
    let documentID: String?
    let data: [String: Any]?
}
