//
//  HistorySegmentedControl.swift
//  AIEnglishSentences
//
//  Created by mert alp on 29.12.2024.
//

import UIKit

protocol HistorySegmentedControlDelegate: AnyObject {
    func segmentChanged(to index: Int)
}

final class HistorySegmentedControl: UIView {

    // MARK: - Properties
    private var buttons: [UIButton] = []
    private let stackView = UIStackView()
    private let selectionIndicator = UIView()
    private var selectedIndexInternal: Int = 0

    weak var delegate: HistorySegmentedControlDelegate?

    var selectedIndex: Int {
        selectedIndexInternal
    }

    // MARK: - Initializer
    init(items: [String]) {
        super.init(frame: .zero)
        setupUI(items: items)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI(items: [String]) {
        buttons = items.enumerated().map { index, title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(index == 0 ? .mainColor : .gray, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            return button
        }

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        buttons.forEach { stackView.addArrangedSubview($0) }
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectionIndicator.backgroundColor = .mainColor
        addSubview(selectionIndicator)
        selectionIndicator.snp.makeConstraints { make in
            make.height.equalTo(UIHelper.dynamicHeight(2))
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(items.count)
        }
    }

    // MARK: - Actions
    @objc private func buttonTapped(_ sender: UIButton) {
        buttons.forEach { $0.setTitleColor(.gray, for: .normal) }
        sender.setTitleColor(.mainColor, for: .normal)

        selectedIndexInternal = sender.tag
        delegate?.segmentChanged(to: selectedIndexInternal)

        UIView.animate(withDuration: 0.3) {
            self.selectionIndicator.snp.remakeConstraints { make in
                make.height.equalTo(UIHelper.dynamicHeight(2))
                make.leading.equalTo(self.stackView.snp.leading).offset(sender.frame.origin.x)
                make.bottom.equalToSuperview()
                make.width.equalToSuperview().dividedBy(self.buttons.count)
            }
            self.layoutIfNeeded()
        }
    }
}
