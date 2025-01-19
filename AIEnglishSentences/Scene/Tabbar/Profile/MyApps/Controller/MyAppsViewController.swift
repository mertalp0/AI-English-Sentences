//
//  MyAppsVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import UIKit
import SnapKit
import BaseMVVMCKit

final class MyAppsViewController: BaseViewController<MyAppsCoordinator, MyAppsViewModel> {
    // MARK: - Properties
    let apps: [AppModel] = AppConstants.myApps

    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var appBar: AppBar!
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    private func setupUI() {

        backgroundImageView = UIImageView()
        backgroundImageView.image =  .appImage(.backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)

        appBar = AppBar(type: .myApps)
        appBar.delegate = self
        view.addSubview(appBar)

        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AppCell.self, forCellReuseIdentifier: "AppCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        view.addSubview(tableView)
    }

    private func setupConstraints() {

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
