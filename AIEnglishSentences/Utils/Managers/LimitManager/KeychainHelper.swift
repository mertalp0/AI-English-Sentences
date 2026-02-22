//
//  KeychainHelper.swift
//  AIEnglishSentences
//

import Foundation
import Security

final class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}

    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        SecItemDelete(query)
        SecItemAdd(query, nil)
    }

    func read(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return result as? Data
    }

    func delete(service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        SecItemDelete(query)
    }
}

extension KeychainHelper {
    func set(_ value: Int, forKey key: String) {
        let data = withUnsafeBytes(of: value) { Data($0) }
        save(data, service: "com.mertalp.AIEnglishSentences.limit", account: key)
    }

    func getInt(forKey key: String) -> Int? {
        guard let data = read(service: "com.mertalp.AIEnglishSentences.limit", account: key) else { return nil }
        return data.withUnsafeBytes { $0.load(as: Int.self) }
    }

    func set(_ value: Date, forKey key: String) {
        let data = withUnsafeBytes(of: value.timeIntervalSince1970) { Data($0) }
        save(data, service: "com.mertalp.AIEnglishSentences.limit", account: key)
    }

    func getDate(forKey key: String) -> Date? {
        guard let data = read(service: "com.mertalp.AIEnglishSentences.limit", account: key) else { return nil }
        let timeInterval = data.withUnsafeBytes { $0.load(as: TimeInterval.self) }
        return Date(timeIntervalSince1970: timeInterval)
    }
}
