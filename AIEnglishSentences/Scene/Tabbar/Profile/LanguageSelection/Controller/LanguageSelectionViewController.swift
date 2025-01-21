//
//  LanguageSelectionVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import UIKit
import BaseMVVMCKit

final class LanguageSelectionViewController: BaseViewController<LanguageSelectionCoordinator, LanguageSelectionViewModel> {

    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var appBar: AppBar!
    private var tableView: UITableView!
    let languages: [String] = [.localized(for: .languageEnglish)]
    var selectedLanguageIndex: Int = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI Setup
private extension LanguageSelectionViewController {

    func setupUI() {
        setupBackgroundImageView()
        setupAppBar()
        setupTableView()
    }

    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView()
        backgroundImageView.image = .appImage(.backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupAppBar() {
        appBar = AppBar(type: .languages)
        appBar.delegate = self
        view.addSubview(appBar)

        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(20))
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
