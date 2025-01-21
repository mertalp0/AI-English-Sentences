//
//  SentenceCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

import UIKit
import SnapKit

protocol SentenceCellDelegate: AnyObject {
    func didTapPlayButton(for sentence: String, in cell: SentenceCell)
    func didTapSaveAndFavorite(for sentence: Sentence, in cell: SentenceCell)
    func didTapCopyButton(for sentence: String, in cell: SentenceCell)
}

enum SentenceCellType {
    case historyCell
    case resultCell
}

final class SentenceCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: SentenceCellDelegate?
    private var currentSentence: Sentence?
    private var type: SentenceCellType? {
        didSet {
            updateSaveAndFavoriteButton()
        }
    }

    // MARK: - UI Elements
    private let containerView = UIView()
    private let sentenceLabel = UILabel()
    private let playButton = UIButton()
    private let saveAndFavoriteButton = UIButton()
    private let copyButton = UIButton()
    private let separatorLine = UIView()
    private let metadataStackView = UIStackView()
    private let writingToneContainer = UIView()
    private let writingToneLabel = UILabel()
    private let writingStyleContainer = UIView()
    private let writingStyleLabel = UILabel()
    private let createdAtLabel = UILabel()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure Cell
    func configure(with sentence: Sentence, type: SentenceCellType) {
        self.currentSentence = sentence
        self.type = type
        sentenceLabel.text = sentence.sentence
        writingToneLabel.text = sentence.writingTone
        writingStyleLabel.text = sentence.writingStyle
        createdAtLabel.text = DateFormatter.localizedString(
                from: sentence.createdAt,
                dateStyle: .medium,
                timeStyle: .none
            )
        updateSaveAndFavoriteButton()
    }

    func updateSaveAndFavoriteButton() {
        guard let sentence = currentSentence else { return }
        let icon: UIImage?
        switch type {
        case .historyCell:
            icon = sentence.favorite ? .appIcon(.starFill) : .appIcon(.star)
        case .resultCell:
            if SentenceManager.shared.sentences.contains(where: { $0.id == sentence.id }) {
                icon = .appIcon(.bookmarkFill)
            } else {
                icon = .appIcon(.bookmark)
            }
        case .none:
            return
        }
        saveAndFavoriteButton.setImage(icon, for: .normal)
    }

    func updatePlayButton(isPlaying: Bool) {
        let icon: UIImage? = isPlaying ? .appIcon(.stopCircle) : .appIcon(.playCircle)
        playButton.setImage(icon, for: .normal)
    }

    // MARK: - Actions
    @objc private func onTapPlay() {
        guard let sentence = currentSentence else { return }
        delegate?.didTapPlayButton(for: sentence.sentence, in: self)
    }

    @objc private func onTapSaveAndFavorite() {
        guard let sentence = currentSentence else { return }
        delegate?.didTapSaveAndFavorite(for: sentence, in: self)
    }

    func updateSaveAndFavoriteButton(for sentence: Sentence) {
        let icon: UIImage?
        if SentenceManager.shared.sentences.contains(where: { $0.id == sentence.id }) {
            icon = .appIcon(.bookmarkFill)
        } else {
            icon = .appIcon(.bookmark)
        }
        UIView.transition(
                with: saveAndFavoriteButton,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
            self.saveAndFavoriteButton.setImage(icon, for: .normal)
        })
    }

    @objc private func onTapCopy() {
          guard let sentence = currentSentence else { return }
          delegate?.didTapCopyButton(for: sentence.sentence, in: self)
      }
}

// MARK: - Setup UI
extension SentenceCell {
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        setupContainerView()
        setupSentenceLabel()
        setupPlayButton()
        setupSaveAndFavoriteButton()
        setupCopyButton()
        setupSeparatorLine()
        setupMetadataStackView()
        setupConstraints()
    }

    private func setupContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(containerView)
    }

    private func setupSentenceLabel() {
        sentenceLabel.font = .dynamicFont(size: 16, weight: .regular)
        sentenceLabel.textColor = .black
        sentenceLabel.numberOfLines = 0
        containerView.addSubview(sentenceLabel)
    }

    private func setupPlayButton() {
        playButton.setImage(.appIcon(.playCircle), for: .normal)
        playButton.tintColor = .mainColor
        containerView.addSubview(playButton)

        playButton.addTarget(self, action: #selector(onTapPlay), for: .touchUpInside)
    }

    private func setupSaveAndFavoriteButton() {
        saveAndFavoriteButton.tintColor = .systemYellow
        containerView.addSubview(saveAndFavoriteButton)

        saveAndFavoriteButton.addTarget(self, action: #selector(onTapSaveAndFavorite), for: .touchUpInside)
    }

    private func setupCopyButton() {
        copyButton.setImage(.appIcon(.docOnDoc), for: .normal)
        copyButton.tintColor = .systemGreen
        containerView.addSubview(copyButton)

        copyButton.addTarget(self, action: #selector(onTapCopy), for: .touchUpInside)
    }

    private func setupSeparatorLine() {
        separatorLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        containerView.addSubview(separatorLine)

    }

    private func setupMetadataStackView() {
        metadataStackView.axis = .horizontal
        metadataStackView.spacing = 8
        metadataStackView.alignment = .center
        containerView.addSubview(metadataStackView)

        setupWritingToneContainer()
        setupWritingStyleContainer()
        setupCreatedAtLabel()
    }

    private func setupWritingToneContainer() {
        writingToneContainer.backgroundColor = .systemPurple
        writingToneContainer.layer.cornerRadius = 8
        writingToneContainer.layer.masksToBounds = true
        metadataStackView.addArrangedSubview(writingToneContainer)

        writingToneLabel.font = .dynamicFont(size: 12, weight: .medium)
        writingToneLabel.textColor = .white
        writingToneLabel.textAlignment = .center
        writingToneLabel.numberOfLines = 1
        writingToneContainer.addSubview(writingToneLabel)
    }

    private func setupWritingStyleContainer() {
        writingStyleContainer.backgroundColor = .systemTeal
        writingStyleContainer.layer.cornerRadius = 8
        writingStyleContainer.layer.masksToBounds = true
        metadataStackView.addArrangedSubview(writingStyleContainer)

        writingStyleLabel.font = .dynamicFont(size: 12, weight: .medium)
        writingStyleLabel.textColor = .white
        writingStyleLabel.textAlignment = .center
        writingStyleLabel.numberOfLines = 1
        writingStyleContainer.addSubview(writingStyleLabel)
    }

    private func setupCreatedAtLabel() {
        createdAtLabel.font = .dynamicFont(size: 12, weight: .light)
        createdAtLabel.textColor = .darkGray
        createdAtLabel.textAlignment = .right
        metadataStackView.addArrangedSubview(createdAtLabel)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        sentenceLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(UIHelper.dynamicHeight(16))
            make.trailing.equalTo(playButton.snp.leading).offset(-8)
        }

        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(saveAndFavoriteButton.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
            make.width.height.equalTo(UIHelper.dynamicHeight(24))
        }

        saveAndFavoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(copyButton.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
            make.width.height.equalTo(UIHelper.dynamicHeight(24))
        }

        copyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
            make.width.height.equalTo(UIHelper.dynamicHeight(24))
        }

        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(sentenceLabel.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }

        writingToneLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        writingStyleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        metadataStackView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
