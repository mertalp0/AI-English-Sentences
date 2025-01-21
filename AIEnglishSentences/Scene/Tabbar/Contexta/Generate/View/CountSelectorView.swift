//
//  CountSelectorView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import SnapKit

protocol CountSelectorViewDelegate: AnyObject {
    func countSelectorView(_ view: CountSelectorView, didSelectValue value: Int)
}

final class CountSelectorView: UIView {

    // MARK: - Properties
    let type: CountSelectorViewType
    private(set) var selectedValue: Int?

    weak var delegate: CountSelectorViewDelegate?

    // MARK: - UI Elements
    private let container = UIView()
    private let titleLabel = UILabel()
    private let optionsStackView = UIStackView()

    // MARK: - Initialization
    init(type: CountSelectorViewType) {
        self.type = type
        super.init(frame: .zero)
        setupUI()
        setupOptions()
        selectedValue = type.values.first
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc private func optionTapped(_ sender: UIButton) {
        guard let value = sender.titleLabel?.text, let intValue = Int(value) else { return }

        selectedValue = intValue
        delegate?.countSelectorView(self, didSelectValue: intValue)
        updateOptionStyles(selectedButton: sender)
    }
}

// MARK: - UI Setup
private extension CountSelectorView {
    private func setupUI() {
        setupContainer()
        setupTitleLabel()
        setupOptionsStackView()
        setupConstraints()
    }

    private func setupContainer() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        addSubview(container)
    }

    private func setupTitleLabel() {
        titleLabel.text = type.title
        titleLabel.font = .dynamicFont(size: 14, weight: .medium)
        titleLabel.textColor = .gray
        container.addSubview(titleLabel)
    }

    private func setupOptionsStackView() {
        optionsStackView.axis = .horizontal
        optionsStackView.alignment = .fill
        optionsStackView.distribution = .fillEqually
        optionsStackView.spacing = 10
        optionsStackView.layer.cornerRadius = 16
        optionsStackView.backgroundColor = .background
        container.addSubview(optionsStackView)
    }

    private func setupConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview().inset(16)
        }

        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-UIHelper.dynamicHeight(10))
            make.height.equalTo(UIHelper.dynamicHeight(50))
        }
    }

    private func setupOptions() {
        for value in type.values {
            let button = createOptionButton(with: "\(value)")
            optionsStackView.addArrangedSubview(button)
        }

        if let firstButton = optionsStackView.arrangedSubviews.first as? UIButton {
            firstButton.backgroundColor = .mainColor?.withAlphaComponent(0.2)
        }
    }

    private func createOptionButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .dynamicFont(size: 18, weight: .medium)
        button.setTitleColor(.mainColor, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
        return button
    }

    private func updateOptionStyles(selectedButton: UIButton) {
        optionsStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.backgroundColor = .white
            }
        }
        selectedButton.backgroundColor = .mainColor?.withAlphaComponent(0.2)
    }
}

// MARK: - CountSelectorViewType
enum CountSelectorViewType {
    case sentence
    case word

    var title: String {
        switch self {
        case .sentence:
            return .localized(for: .sentenceCountTitle)
        case .word:
            return .localized(for: .maxWordCountTitle)
        }
    }

    var values: [Int] {
        switch self {
        case .sentence:
            return [5, 10, 15, 20]
        case .word:
            return [5, 15, 25, 35]
        }
    }
}
