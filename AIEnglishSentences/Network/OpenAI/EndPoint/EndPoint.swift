//
//  EndPoint.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

enum HTTPMethd: String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct EndPoint {
    let path: String
    let method: HTTPMethd
    let headers: [String:String]
    let body: Data?
}
