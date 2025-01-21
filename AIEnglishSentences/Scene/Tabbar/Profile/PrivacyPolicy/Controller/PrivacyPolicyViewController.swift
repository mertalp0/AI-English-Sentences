//
//  PrivacyPolicyVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import UIKit
import WebKit
import BaseMVVMCKit

final class PrivacyPolicyViewController: BaseViewController<PrivacyPolicyCoordinator, PrivacyPolicyViewModel> {

    // MARK: - UI Elements
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPrivacyPolicy()
    }

    // MARK: - Load Privacy Policy
    private func loadPrivacyPolicy() {
        guard let url = viewModel.getPrivacyPolicyURL() else {
            self.showAlert(title: "Error", message: "Invalid URL for Privacy Policy.")
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - Setup UI
private extension PrivacyPolicyViewController {

    private func setupUI() {
       setupWebView()
    }

    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)

        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
