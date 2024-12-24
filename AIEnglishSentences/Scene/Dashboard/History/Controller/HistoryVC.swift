//
//  HistoryVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import NotificationCenter
import BaseMVVMCKit

final class HistoryVC: BaseViewController<HistoryCoordinator, HistoryViewModel>{
    
    // MARK: - UI Elements
    private var pageTitle: UILabel!
    private weak var getSentencesButton: CustomButton?
    private weak var deleteSentencesButton: CustomButton?
    private var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupActions()
        setupNC()
        fetchSentences()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .generateModelsUpdated, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Page Title
        let titleLabel = UILabel()
        titleLabel.text = String(describing: type(of: self))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIHelper.statusBarHeight + 10)
            make.centerX.equalToSuperview()
        }
        pageTitle = titleLabel
        
        // Generate Button
        let getSentencesBtn = CustomButton()
        getSentencesBtn.configure(title: "Get Sentences", backgroundColor: .systemBlue, textColor: .white)
        view.addSubview(getSentencesBtn)
        getSentencesBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
        }
        getSentencesButton = getSentencesBtn
        
        // Save Sentences Button
        let deleteSentencesBtn = CustomButton()
        deleteSentencesBtn.configure(title: "Delete Sentences", backgroundColor: .systemGreen, textColor: .white)
        view.addSubview(deleteSentencesBtn)
        deleteSentencesBtn.snp.makeConstraints { make in
            make.bottom.equalTo(getSentencesBtn.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        deleteSentencesButton = deleteSentencesBtn
    }
    
    private func setupTableView(){
        tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GenerateCell.self, forCellReuseIdentifier: "GenerateCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupActions() {
        getSentencesButton?.addTarget(self, action: #selector(onTapGetSentences), for: .touchUpInside)
        deleteSentencesButton?.addTarget(self, action: #selector(onTaDeleteSentences), for: .touchUpInside)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HistoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GenerateManager.shared.generateModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenerateCell", for: indexPath) as? GenerateCell else {
            return UITableViewCell()
        }
        let model = GenerateManager.shared.generateModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = GenerateManager.shared.generateModels[indexPath.row]
        print("Selected Words: \(model.words), Sentences Count: \(model.sentences.count)")
        coordinator?.showSentences(sentences: model.sentences)
    }
}

//MARK: - Fetch Sentences
extension HistoryVC {
    private func fetchSentences(){
        viewModel.fetchSentences()
    }
}

//MARK: - NotificationCenter
extension HistoryVC {
    private func setupNC() {
        NotificationCenter.default.addObserver(self, selector: #selector(generateModelsDidUpdate), name: .generateModelsUpdated, object: nil)
    }
}


// MARK: - Actions
extension HistoryVC {
    @objc private func onTapGetSentences() {
        guard let button = getSentencesButton else { return }
        print("Get Sentences Button tapped: \(button)")
        
    }
    
    @objc private func onTaDeleteSentences() {
        guard let button = deleteSentencesButton else { return }
        print("Delete Sentences Button tapped: \(button)")
        
    }
    
    @objc private func generateModelsDidUpdate() {
        tableView.reloadData()
    }
}
