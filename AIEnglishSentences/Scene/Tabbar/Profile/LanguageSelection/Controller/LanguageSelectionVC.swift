//
//  LanguageSelectionVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import UIKit
import BaseMVVMCKit

final class LanguageSelectionVC: BaseViewController<LanguageSelectionCoordinator, LanguageSelectionViewModel> {
    
    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var appBar: AppBar!
    private var tableView: UITableView!
    
    // Dil seçenekleri
    private let languages: [String] = ["English", ]
    private var selectedLanguageIndex: Int = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        
        // Background Image
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        // AppBar
        appBar = AppBar(type: .languages)
        appBar.delegate = self
        view.addSubview(appBar)
        
        // TableView
        tableView = UITableView()
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        // Background ImageView
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // AppBar
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
        
        // TableView
        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(20))
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: - AppBarDelegate
extension LanguageSelectionVC: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.back()
    }
    
    func rightButtonTapped() {
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension LanguageSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier, for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }
        let language = languages[indexPath.row]
        let isSelected = indexPath.row == selectedLanguageIndex
        cell.configure(with: language, isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguageIndex = indexPath.row
        tableView.reloadData()
    }
}

