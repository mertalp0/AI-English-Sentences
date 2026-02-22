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
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 12
        layer.masksToBounds = true

        setupSelectionIndicator(itemCount: items.count)
        setupButtons(items: items)
        setupStackView()
    }

    func setupButtons(items: [String]) {
        buttons = items.enumerated().map { index, title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .dynamicFont(size: 14, weight: index == 0 ? .semibold : .regular)
            button.setTitleColor(index == 0 ? .mainColor : .secondaryLabel, for: .normal)
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
        selectionIndicator.backgroundColor = .systemBackground
        selectionIndicator.layer.cornerRadius = 10
        selectionIndicator.layer.shadowColor = UIColor.black.cgColor
        selectionIndicator.layer.shadowOpacity = 0.08
        selectionIndicator.layer.shadowOffset = CGSize(width: 0, height: 2)
        selectionIndicator.layer.shadowRadius = 4
        addSubview(selectionIndicator)

        selectionIndicator.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            make.leading.equalToSuperview().inset(3)
            make.width.equalToSuperview().dividedBy(itemCount).offset(-3)
        }
    }
}

// MARK: - Actions
private extension HistorySegmentedControl {
    @objc func buttonTapped(_ sender: UIButton) {
        buttons.forEach {
            $0.setTitleColor(.secondaryLabel, for: .normal)
            $0.titleLabel?.font = .dynamicFont(size: 14, weight: .regular)
        }
        sender.setTitleColor(.mainColor, for: .normal)
        sender.titleLabel?.font = .dynamicFont(size: 14, weight: .semibold)

        selectedIndexInternal = sender.tag
        delegate?.segmentChanged(to: selectedIndexInternal)

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5) {
            self.selectionIndicator.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(3)
                make.leading.equalTo(self.stackView.snp.leading).offset(sender.frame.origin.x + 3)
                make.width.equalToSuperview().dividedBy(self.buttons.count).offset(-3)
            }
            self.layoutIfNeeded()
        }
    }
}
