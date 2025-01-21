//
//  Logger.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import Foundation

enum LogType: String {
    case network = "🌐 Network"
    case error = "❌ Error"
    case debug = "🐞 Debug"
    case info = "ℹ️ Info"
    case warning = "⚠️ Warning"

}

final class Logger {
    static var isLoggingEnabled = true

    static func log(_ message: String, type: LogType = .info, file: String = #file, function: String = #function, line: Int = #line) {
        guard isLoggingEnabled else { return }
        let fileName = (file as NSString).lastPathComponent
        print("[\(type.rawValue)] [\(fileName):\(line)] \(function) - \(message)")
    }
}
