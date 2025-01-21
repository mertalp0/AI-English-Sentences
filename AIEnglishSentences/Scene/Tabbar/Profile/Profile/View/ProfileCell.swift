import UIKit
import SnapKit

final class ProfileCell: UITableViewCell {

    // MARK: - UI Elements
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure Cell
    func configure(with title: String, icon: UIImage?) {
        titleLabel.text = title
        iconImageView.image = icon
    }
}

// MARK: - Setup UI
private extension ProfileCell {
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        setupIconImageView()
        setupTitleLabel()
        setupArrowImageView()
    }

    private func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .mainColor
        contentView.addSubview(iconImageView)
    }

    private func setupTitleLabel() {
        titleLabel.font = .dynamicFont(size: 18, weight: .medium)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
    }

    private func setupArrowImageView() {
        arrowImageView.image = .appIcon(.chevronRight)
        arrowImageView.tintColor = .lightGray
        contentView.addSubview(arrowImageView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(28))
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}
