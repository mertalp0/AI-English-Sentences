//
//  ResultVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import UIKit
import BaseMVVMCKit

final class ResultViewController: BaseViewController<ResultCoordinator, ResultViewModel> {

    // MARK: - Properties
    var sentences: [Sentence]?

    // MARK: - UI Elements
    private var appBar: AppBar!
    private var sentencesTableView: SentencesTableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureTableView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        TextToSpeechManager.shared.stopSpeaking()
    }

   private func configureTableView() {
        guard let sentences = self.sentences else { return }
        sentencesTableView.configure(with: sentences)
    }
}

// MARK: - UI Setup
private extension ResultViewController {

   private  func setupUI() {
        setupAppBar()
        setupSentencesTableView()
    }

    private func setupAppBar() {
        appBar = AppBar(type: .result)
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
    }

    private func setupSentencesTableView() {
        sentencesTableView = SentencesTableView()
        sentencesTableView.delegate = self
        view.addSubview(sentencesTableView)
        sentencesTableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}
