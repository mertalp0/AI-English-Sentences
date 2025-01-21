//
//  PrivacyPolicyViewController+WKNavigationDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.01.2025.
//

import WebKit

// MARK: - WKNavigationDelegate
extension PrivacyPolicyViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showAlert(title: "Error", message: "Failed to load Privacy Policy")
    }
}
