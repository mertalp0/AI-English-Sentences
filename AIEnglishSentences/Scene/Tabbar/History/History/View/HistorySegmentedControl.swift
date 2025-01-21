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
    private var stackView: UIStackView!
    private var selectionIndicator: UIView!
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
}

// MARK: - Setup UI
private extension HistorySegmentedControl {
    func setupUI(items: [String]) {
        setupButtons(items: items)
        setupStackView()
        setupSelectionIndicator(itemCount: items.count)
    }

    func setupButtons(items: [String]) {
        buttons = items.enumerated().map { index, title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(index == 0 ? .mainColor : .gray, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            return button
        }
    }

    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupSelectionIndicator(itemCount: Int) {
        selectionIndicator = UIView()
        selectionIndicator.backgroundColor = .mainColor
        addSubview(selectionIndicator)

        selectionIndicator.snp.makeConstraints { make in
            make.height.equalTo(UIHelper.dynamicHeight(2))
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(itemCount)
        }
    }
}

// MARK: - Actions
private extension HistorySegmentedControl {
    @objc func buttonTapped(_ sender: UIButton) {
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
