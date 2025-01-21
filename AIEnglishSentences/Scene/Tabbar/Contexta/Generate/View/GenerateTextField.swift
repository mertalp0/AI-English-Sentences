//
//  GenerateTextView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 17.12.2024.
//

import UIKit
import SnapKit

final class GenerateTextView: UITextView {

    private var placeholderLabel: UILabel!
    private var maxNumberOfLines: Int = 5

    // MARK: - Initialization
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setup UI
private extension GenerateTextView {
    private func setupUI() {
        setupTextView()
        setupPlaceholderLabel()
    }

    private func setupTextView() {
        self.backgroundColor = .backgroundColor
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textColor = .black
        self.font = .dynamicFont(size: 16)
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        self.delegate = self
    }

    private func setupPlaceholderLabel() {
        placeholderLabel = UILabel()
        placeholderLabel.font = .dynamicFont(size: 14)
        placeholderLabel.textColor = .gray
        placeholderLabel.text = .localized(for: .generateTextViewPlaceholder)
        addSubview(placeholderLabel)

        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(8))
        }
    }
}

// MARK: - Placeholder Handling
private extension GenerateTextView {
    func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
}

// MARK: - Public Methods
extension GenerateTextView {
    func setMaxNumberOfLines(_ lines: Int) {
        self.maxNumberOfLines = lines
    }

    func calculateHeight() -> CGFloat {
        guard let font = self.font else { return 0 }
        let lineHeight = font.lineHeight
        return lineHeight * CGFloat(maxNumberOfLines)
    }
}

// MARK: - UITextViewDelegate
extension GenerateTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderVisibility()
        let maxHeight = calculateHeight()
        if self.contentSize.height > maxHeight {
            self.isScrollEnabled = true
            self.isScrollEnabled = false
        }
    }
}
