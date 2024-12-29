import UIKit
import SnapKit

final class GenerateTextView: UITextView {

    // MARK: - Placeholder Label
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Write your sentence topic here...?"
        return label
    }()

    // MARK: - Maximum Satır Sayısı
    private var maxNumberOfLines: Int = 5

    // MARK: - Initialization
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {

        self.backgroundColor = .init(hex: "E9F1FF")
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 16)
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        self.delegate = self

        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
    }

    // MARK: - Placeholder Görünüm Güncellemesi
    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }

    // MARK: - Maksimum Satır Sayısını Ayarlama
    func setMaxNumberOfLines(_ lines: Int) {
        self.maxNumberOfLines = lines
    }

    // MARK: - Dinamik Yükseklik Hesaplama
    private func calculateHeight() -> CGFloat {
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
