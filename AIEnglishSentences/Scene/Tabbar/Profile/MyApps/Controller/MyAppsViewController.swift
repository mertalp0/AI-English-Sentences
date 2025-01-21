//
//  MyAppsVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import UIKit
import SnapKit
import BaseMVVMCKit

final class MyAppsViewController: BaseViewController<MyAppsCoordinator, BaseViewModel> {
    // MARK: - Properties
    let apps: [AppModel] = AppConstants.myApps

    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var appBar: AppBar!
    private var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI Setup
private extension MyAppsViewController {

    private func setupUI() {
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
        appBar = AppBar(type: .myApps)
        appBar.delegate = self
        view.addSubview(appBar)

        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AppCell.self, forCellReuseIdentifier: "AppCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
