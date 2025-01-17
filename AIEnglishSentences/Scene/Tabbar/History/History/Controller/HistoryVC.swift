//
//  HistoryVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class HistoryVC: BaseViewController<HistoryCoordinator, HistoryViewModel> {
    
    // MARK: - UI Elements
    private var appBar: AppBar!
    private var historySegmentedControl: HistorySegmentedControl!
    private var tableView: UITableView!
    private var emptyStateView: EmptyStateView!
    private var currentlyPlayingCell: SentenceCell?
    
    // MARK: - Properties
    private let textToSpeechManager =  TextToSpeechManager.shared
    private var allData: [Sentence] = []
    private var favouritesData: [Sentence] = []
    private var currentData: [Sentence] {
        return historySegmentedControl.selectedIndex == 0 ? allData : favouritesData
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotificationCenter()
        fetchSentences()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUIForCurrentData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopCurrentSpeaking()
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        // AppBar
        appBar = AppBar(type: .history)
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
        
        // Custom Segmented Control
        historySegmentedControl = HistorySegmentedControl(items: [    .localized(for: .historySegmentAll), .localized(for: .historySegmentFavourites)])
        historySegmentedControl.delegate = self
        view.addSubview(historySegmentedControl)
        historySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }
        
        // TableView
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SentenceCell.self, forCellReuseIdentifier: "SentenceCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(historySegmentedControl.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // Empty State
        emptyStateView = EmptyStateView()
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(onSentencesUpdated), name: SentenceManager.sentencesUpdatedNotification, object: nil)
    }
    
    private func fetchSentences(){
        viewModel.fetchSentences { isSucces in
            self.loadInitialData()
            self.updateUIForCurrentData()
        }}
    
    private func loadInitialData() {
        allData = SentenceManager.shared.sentences
        favouritesData = allData.filter {$0.favorite}
        tableView.reloadData()
    }
    
    @objc private func onSentencesUpdated() {
        allData = SentenceManager.shared.sentences
        tableView.reloadData()
    }
    
    private func updateUIForCurrentData() {
        stopCurrentSpeaking()
        
        let isDataEmpty = currentData.isEmpty
        emptyStateView.isHidden = !isDataEmpty
        tableView.isHidden = isDataEmpty
        
        if isDataEmpty {
            if historySegmentedControl.selectedIndex == 0 {
                emptyStateView.configure(
                    image: .appImage(.historyAllEmpty),
                    title: .localized(for: .historyEmptyAllTitle),
                    description: .localized(for: .historyEmptyAllDescription)
                )
            } else {
                emptyStateView.configure(
                    image: .appImage(.historyFavoritesEmpty),
                    title: .localized(for: .historyEmptyFavouritesTitle),
                    description: .localized(for: .historyEmptyFavouritesDescription)
                )
            }
        } else {
            tableView.reloadData()
        }
    }
    
    private func stopCurrentSpeaking() {
        currentlyPlayingCell?.updatePlayButton(isPlaying: false)
        textToSpeechManager.stopSpeaking()
        currentlyPlayingCell = nil
    }
}

// MARK: - UITableViewDataSource
extension HistoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceCell", for: indexPath) as? SentenceCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(with: currentData[indexPath.row], type: .historyCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if historySegmentedControl.selectedIndex != 0 {
            return nil
        }
        
        let sentence = currentData[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: .localized(for: .historyDeleteAlertConfirm)) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            self.didTapDelete(for: sentence, in: tableView.cellForRow(at: indexPath) as! SentenceCell)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - CustomSegmentedControlDelegate
extension HistoryVC: HistorySegmentedControlDelegate {
    func segmentChanged(to index: Int) {
        updateUIForCurrentData()
    }
}

extension HistoryVC: AppBarDelegate {
    func leftButtonTapped() {}
    
    func rightButtonTapped() {}
}

// MARK: - SentenceCellDelegate
extension HistoryVC: SentenceCellDelegate {
    func didTapCopyButton(for sentence: String, in cell: SentenceCell) {
        UIPasteboard.general.string = sentence
        showToast(message: .localized(for: .historyCopiedToClipboard))
    }
    
    
    func didTapSaveAndFavorite(for sentence: Sentence, in cell: SentenceCell) {
        
        
        if let indexInAllData = SentenceManager.shared.sentences.firstIndex(where: { $0.id == sentence.id }) {
            var updatedSentence = sentence
            updatedSentence.favorite.toggle()
            
            if updatedSentence.favorite {
                viewModel.addFavoriteSentence(sentence: updatedSentence) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        if !self.favouritesData.contains(where: { $0.id == updatedSentence.id }) {
                            self.favouritesData.append(updatedSentence)
                        }
                        SentenceManager.shared.updateSentence(updatedSentence, at: indexInAllData)
                        self.updateUIForCurrentData()
                    }
                }
            } else {
                viewModel.deleteFavoriteSentence(sentence: updatedSentence) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        if let indexInFavorites = self.favouritesData.firstIndex(where: { $0.id == updatedSentence.id }) {
                            self.favouritesData.remove(at: indexInFavorites)
                        }
                        SentenceManager.shared.updateSentence(updatedSentence, at: indexInAllData)
                        self.updateUIForCurrentData()
                    }
                }
            }
        }
    }
    
    func didTapPlayButton(for sentence: String, in cell: SentenceCell) {
        if let currentlyPlayingCell = currentlyPlayingCell, currentlyPlayingCell == cell {
            stopCurrentSpeaking()
        } else {
            stopCurrentSpeaking()
            
            textToSpeechManager.speak(text: sentence)
            cell.updatePlayButton(isPlaying: true)
            currentlyPlayingCell = cell
        }
    }
    
    func didTapDelete(for sentence: Sentence, in cell: SentenceCell) {
        let alertController = UIAlertController(
            title: .localized(for: .historyDeleteAlertTitle),
            message: .localized(for: .historyDeleteAlertMessage),
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(
            title: .localized(for: .historyDeleteAlertCancel),
            style: .cancel,
            handler: nil
        ))
        alertController.addAction(UIAlertAction(
            title: .localized(for: .historyDeleteAlertConfirm),
            style: .destructive
        ) { [weak self] _ in
            self?.deleteSentence(sentence: sentence)
        })
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func deleteSentence(sentence: Sentence) {
        viewModel.deleteSentence(sentence: sentence) { [weak self] isSuccess in
            if isSuccess {
                self?.loadInitialData()
                self?.updateUIForCurrentData()
            }
        }
    }
}
