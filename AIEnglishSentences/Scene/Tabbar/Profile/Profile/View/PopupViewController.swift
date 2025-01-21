import UIKit

protocol PopupViewControllerDelegate: AnyObject {
    func popupDidCancel(popupType: PopupType)
    func popupDidConfirm(popupType: PopupType)
}

enum PopupType {
    case logout
    case delete
    case custom(title: String, message: String)
}

final class PopupViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: PopupViewControllerDelegate?
    private let popupType: PopupType
    private let iconImage: UIImage?
    private let cancelButtonText: String?
    private let confirmButtonText: String?

    // MARK: - UI Elements
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton(type: .system)
    private let confirmButton = UIButton(type: .system)

    // MARK: - Initializer
    init(popupType: PopupType, icon: UIImage?, cancelText: String?, confirmText: String?) {
        self.popupType = popupType
        self.iconImage = icon
        self.cancelButtonText = cancelText
        self.confirmButtonText = confirmText
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI Setup
private extension PopupViewController {
    func setupUI() {
        setupBackground()
        setupContainerView()
        setupIconImageView()
        setupLabels()
        setupButtons()
    }

    func setupBackground() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    func setupContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        view.addSubview(containerView)

        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }

    func setupIconImageView() {
        guard let iconImage = iconImage else { return }

        iconImageView.image = iconImage
        iconImageView.tintColor = .mainColor
        containerView.addSubview(iconImageView)

        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(20))
            make.centerX.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(40))
        }
    }

    func setupLabels() {
        let (title, message) = getTitleAndMessage()

        titleLabel.text = title
        titleLabel.font = .dynamicFont(size: 18, weight: .semibold)
        titleLabel.textColor = .mainColor
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview().inset(16)
        }

        messageLabel.text = message
        messageLabel.font = .dynamicFont(size: 14, weight: .regular)
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        containerView.addSubview(messageLabel)

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    func setupButtons() {
        cancelButton.setTitle(cancelButtonText, for: .normal)
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.titleLabel?.font = .dynamicFont(size: 16, weight: .medium)
        cancelButton.addTarget(self, action: #selector(onCancelTapped), for: .touchUpInside)
        containerView.addSubview(cancelButton)

        confirmButton.setTitle(confirmButtonText, for: .normal)
        confirmButton.setTitleColor(.systemRed, for: .normal)
        confirmButton.titleLabel?.font = .dynamicFont(size: 16, weight: .medium)
        confirmButton.addTarget(self, action: #selector(onConfirmTapped), for: .touchUpInside)
        containerView.addSubview(confirmButton)

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(UIHelper.dynamicHeight(20))
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(UIHelper.dynamicHeight(44))
            make.bottom.equalToSuperview().offset(-UIHelper.dynamicHeight(16))
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top)
            make.leading.equalTo(cancelButton.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(cancelButton.snp.height)
            make.width.equalTo(cancelButton.snp.width)
        }
    }

    func getTitleAndMessage() -> (title: String, message: String) {
        switch popupType {
        case .logout:
            return (.localized(for: .popupLogoutTitle), .localized(for: .popupLogoutMessage))
        case .delete:
            return (.localized(for: .popupDeleteTitle), .localized(for: .popupDeleteMessage))
        case .custom(let title, let message):
            return (title, message)
        }
    }
}

// MARK: - Actions
private extension PopupViewController {
    @objc func onCancelTapped() {
        delegate?.popupDidCancel(popupType: popupType)
    }

    @objc func onConfirmTapped() {
        dismiss(animated: true) {
            self.delegate?.popupDidConfirm(popupType: self.popupType)
        }
    }
}
