//
//  FirebaseResponse.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import Foundation

struct FirebaseResponse<T: Decodable> {
    let data: T?
    let error: Error?
}
