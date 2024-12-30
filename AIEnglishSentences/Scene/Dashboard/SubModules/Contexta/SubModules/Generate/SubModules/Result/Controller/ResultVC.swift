//
//  ResultVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import UIKit
import BaseMVVMCKit

final class ResultVC: BaseViewController<ResultCoordinator, ResultViewModel> {
    
    // MARK: - Properties
    var sentences: [NewSentence]?
    
    // MARK: - UI Elements
    private var pageTitle: UILabel!
    private var backButton: CustomButton!
    private var sentencesTableView: SentencesTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupActions()
        configureTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TextToSpeechManager.shared.stopSpeaking()
    }
    
    private func setupUI() {
        // Page Title
        pageTitle = UILabel()
        pageTitle.text = String(describing: type(of: self))
        pageTitle.textColor = .black
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 10)
        }
        
        // Back Button
        backButton = CustomButton()
        backButton.configure(title: "Back", backgroundColor: .systemGreen, textColor: .white)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-250)
        }
        
    
        // Sentences TableView
        sentencesTableView = SentencesTableView()
        sentencesTableView.delegate = self
        view.addSubview(sentencesTableView)
        sentencesTableView.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom)
            make.bottom.equalTo(backButton.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
    }
    
    private func configureTableView() {
        guard let sentences = self.sentences else { return }
        sentencesTableView.configure(with: sentences)
    }
}

// MARK: - Actions
extension ResultVC {
    @objc func onTapBack() {
        coordinator?.showRoot()
    }

    private func showSuccesAlert() {
        let alert = UIAlertController(title: "Success", message: "Registration successful", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


extension ResultVC: SentenceTableViewDelegate {
    func didTapSave(for sentence: NewSentence, in cell: SentenceCell) {
        viewModel.saveSentence(sentence: sentence) { isSucces in
            if isSucces {
                self.showSuccesAlert()
            }
        }
    }
}
 
