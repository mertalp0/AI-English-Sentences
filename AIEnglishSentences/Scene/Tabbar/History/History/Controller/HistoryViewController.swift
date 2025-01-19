//
//  HistoryVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class HistoryViewController: BaseViewController<HistoryCoordinator, HistoryViewModel> {

    // MARK: - UI Elements
    private var appBar: AppBar!
    var historySegmentedControl: HistorySegmentedControl!
    private var tableView: UITableView!
    private var emptyStateView: EmptyStateView!
    var currentlyPlayingCell: SentenceCell?

    // MARK: - Properties
    let textToSpeechManager =  TextToSpeechManager.shared
    private var allData: [Sentence] = []
    var favouritesData: [Sentence] = []
    var currentData: [Sentence] {
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
        super.viewWillAppear(animated)
        updateUIForCurrentData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCurrentSpeaking()
    }

    private func setupUI() {
        view.backgroundColor = .backgroundColor
        appBar = AppBar(type: .history)
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }

        historySegmentedControl = HistorySegmentedControl(items: [.localized(for: .historySegmentAll), .localized(for: .historySegmentFavourites)])
        historySegmentedControl.delegate = self
        view.addSubview(historySegmentedControl)
        historySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }

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

    private func fetchSentences() {
        viewModel.fetchSentences { _ in
            self.loadInitialData()
            self.updateUIForCurrentData()
        }}

     func loadInitialData() {
        allData = SentenceManager.shared.sentences
        favouritesData = allData.filter {$0.favorite}
        tableView.reloadData()
    }

    @objc private func onSentencesUpdated() {
        allData = SentenceManager.shared.sentences
        tableView.reloadData()
    }

    func updateUIForCurrentData() {
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

     func stopCurrentSpeaking() {
        currentlyPlayingCell?.updatePlayButton(isPlaying: false)
        textToSpeechManager.stopSpeaking()
        currentlyPlayingCell = nil
    }
}
