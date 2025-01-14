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
    var sentences: [Sentence]?
    
    // MARK: - UI Elements
    private var appBar: AppBar!
    private var sentencesTableView: SentencesTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureTableView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TextToSpeechManager.shared.stopSpeaking()
    }
    
    private func setupUI() {
        
        // AppBar
        appBar = AppBar(type: .result)
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
    
        // Sentences TableView
        sentencesTableView = SentencesTableView()
        sentencesTableView.delegate = self
        view.addSubview(sentencesTableView)
        sentencesTableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        guard let sentences = self.sentences else { return }
        sentencesTableView.configure(with: sentences)
    }
}

// MARK: - Alert
extension ResultVC {
    
    private func showSuccesAlert() {
        let alert = UIAlertController(title: "Success", message: "Registration successful", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}


extension ResultVC: SentenceTableViewDelegate {
    func didTapCopyButton(for sentence: String, in cell: SentenceCell) {
        UIPasteboard.general.string = sentence
        showToast(message: "Copied to clipboard!")
    }
     
    func didTapSave(for sentence: Sentence, in cell: SentenceCell) {
        if SentenceManager.shared.sentences.contains(where: { $0.id == sentence.id }) {
            
            viewModel.deleteSentence(sentence: sentence) { [weak self] isSuccess in
                guard let self = self else { return }
                if isSuccess {
                    cell.updateSaveAndFavoriteButton(for: sentence)
                    self.showAlert(title: "Success", message: "Sentence removed successfully.")
                } else {
                    self.showAlert(title: "Error", message: "Failed to remove sentence.")
                }
            }
        } else {
            viewModel.saveSentence(sentence: sentence) { [weak self] isSuccess in
                guard let self = self else { return }
                if isSuccess {
                    cell.updateSaveAndFavoriteButton(for: sentence)
                    self.showAlert(title: "Success", message: "Sentence saved successfully.")
                } else {
                    self.showAlert(title: "Error", message: "Failed to save sentence.")
                }
            }
        }
    }
    
}
 
extension ResultVC: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.showRoot()

    }
    
    func rightButtonTapped() {
        
    }
    
}
