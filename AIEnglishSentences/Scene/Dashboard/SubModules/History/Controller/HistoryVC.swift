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
    private var emptyStateImageView: UIImageView!
    private var currentlyPlayingCell: SentenceCell?
    
    // MARK: - Properties
    private let textToSpeechManager =  TextToSpeechManager.shared
    private var allData: [NewSentence] = []
    private var favouritesData: [NewSentence] = []
    private var currentData: [NewSentence] {
        return historySegmentedControl.selectedIndex == 0 ? allData : favouritesData
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotificationCenter()
        fetchSentences()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopCurrentSpeaking()
    }
    
    private func setupUI() {
        view.backgroundColor = .init(hex: "F2F2F2")
        
        // AppBar
        appBar = AppBar(type: .history)
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 10)
        }
        
        // Custom Segmented Control
        historySegmentedControl = HistorySegmentedControl(items: ["All", "Favourites"])
        historySegmentedControl.delegate = self
        view.addSubview(historySegmentedControl)
        historySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
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
            make.top.equalTo(historySegmentedControl.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // Empty State ImageView
        emptyStateImageView = UIImageView()
        emptyStateImageView.contentMode = .scaleAspectFit
        emptyStateImageView.isHidden = true
        view.addSubview(emptyStateImageView)
        emptyStateImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
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
        tableView.reloadData()
    }
    
    @objc private func onSentencesUpdated() {
        allData = SentenceManager.shared.sentences
        tableView.reloadData()
    }
    
    private func updateUIForCurrentData() {
        stopCurrentSpeaking()
        
        let isDataEmpty = currentData.isEmpty
        
        let emptyImageName = historySegmentedControl.selectedIndex == 0
        ? "history_all_empty_image"
        : "history_favorites_empty_image"
        emptyStateImageView.image = UIImage(named: emptyImageName)
        
        tableView.isHidden = isDataEmpty
        emptyStateImageView.isHidden = !isDataEmpty
        
        if !isDataEmpty {
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
    
    func didTapSave(for sentence: NewSentence, in cell: SentenceCell) {
        if let indexInAllData = SentenceManager.shared.sentences.firstIndex(where: { $0.id == sentence.id }) {
            var updatedSentence = sentence
            updatedSentence.favorite.toggle()
            
            if updatedSentence.favorite {
                if !favouritesData.contains(where: { $0.id == updatedSentence.id }) {
                    favouritesData.append(updatedSentence)
                    print("\(updatedSentence.sentence) favorilere eklendi.")
                }
            } else {
                if let indexInFavorites = favouritesData.firstIndex(where: { $0.id == updatedSentence.id }) {
                    favouritesData.remove(at: indexInFavorites)
                    print("\(updatedSentence.sentence) favorilerden çıkarıldı.")
                }
            }
            
            SentenceManager.shared.updateSentence(updatedSentence, at: indexInAllData)
        }
        updateUIForCurrentData()     }
    
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
}
