import UIKit
import SnapKit

final class ProfileCell: UITableViewCell {

    // MARK: - UI Elements
    private let containerView = UIView()
    private let iconContainerView = UIView()
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

    // MARK: - Press Animation
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.15) {
            self.containerView.transform = highlighted ? CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
            self.containerView.alpha = highlighted ? 0.85 : 1.0
        }
    }
}

// MARK: - Setup UI
private extension ProfileCell {
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        setupContainerView()
        setupIconContainerView()
        setupIconImageView()
        setupTitleLabel()
        setupArrowImageView()
    }

    private func setupContainerView() {
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 14
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 6
        contentView.addSubview(containerView)
    }

    private func setupIconContainerView() {
        iconContainerView.backgroundColor = UIColor.mainColor?.withAlphaComponent(0.1)
        iconContainerView.layer.cornerRadius = 10
        containerView.addSubview(iconContainerView)
    }

    private func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .mainColor
        iconContainerView.addSubview(iconImageView)
    }

    private func setupTitleLabel() {
        titleLabel.font = .dynamicFont(size: 16, weight: .medium)
        titleLabel.textColor = .label
        containerView.addSubview(titleLabel)
    }

    private func setupArrowImageView() {
        arrowImageView.image = .appIcon(.chevronRight)
        arrowImageView.tintColor = .tertiaryLabel
        containerView.addSubview(arrowImageView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        iconContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(36))
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(20))
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconContainerView.snp.trailing).offset(14)
            make.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
    }
}
