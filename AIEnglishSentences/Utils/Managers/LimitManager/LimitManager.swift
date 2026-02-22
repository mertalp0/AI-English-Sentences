//
//  LimitManager.swift
//  AIEnglishSentences
//

import Foundation

final class LimitManager {
    static let shared = LimitManager()
    private let keychain = KeychainHelper.shared
    
    private let countKey = "sentence_count"
    private let resetDateKey = "reset_date"
    
    private init() {
        checkAndResetIfNeeded()
    }
    
    var currentCount: Int {
        return keychain.getInt(forKey: countKey) ?? 0
    }
    
    var resetDate: Date? {
        return keychain.getDate(forKey: resetDateKey)
    }
    
    func incrementCount() {
        let newCount = currentCount + 1
        keychain.set(newCount, forKey: countKey)
    }
    
    func canGenerate(limit: Int) -> Bool {
        checkAndResetIfNeeded()
        return currentCount < limit
    }
    
    private func checkAndResetIfNeeded() {
        guard let resetDate = resetDate else {
            // First time use, set reset date to 1 month from now
            setInitialResetDate()
            return
        }
        
        if Date() >= resetDate {
            // Reset count and set next reset date
            keychain.set(0, forKey: countKey)
            setNextResetDate(from: resetDate)
        }
    }
    
    private func setInitialResetDate() {
        let calendar = Calendar.current
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: Date()) {
            keychain.set(nextMonth, forKey: resetDateKey)
            keychain.set(0, forKey: countKey)
        }
    }
    
    private func setNextResetDate(from lastResetDate: Date) {
        let calendar = Calendar.current
        // Add 1 month to the existing reset date to keep it on the same day if possible
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: lastResetDate) {
            // If the next month is still in the past (e.g. app wasn't opened for months), 
            // keep adding until we reach future
            if nextMonth <= Date() {
                setNextResetDate(from: nextMonth)
            } else {
                keychain.set(nextMonth, forKey: resetDateKey)
            }
        }
    }
}
