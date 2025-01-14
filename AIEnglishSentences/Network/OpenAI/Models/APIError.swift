//
//  APIError.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case noData
}
