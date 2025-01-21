//
//  ProfileHeaderView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 02.01.2025.
//

import UIKit
import SnapKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func didUpdateName(_ newName: String)
}

final class ProfileHeaderView: UIView {

    // MARK: - UI Elements
    private var appBar: AppBar!
    private var avatarImageView: UIImageView!
    private var nameLabel: UILabel!
    private var nameTextField: UITextField!
    private var emailLabel: UILabel!
    private var editButton: UIButton!

    weak var delegate: ProfileHeaderViewDelegate?

    // MARK: - Properties
    var isEditingName = false {
        didSet {
            updateEditingState()
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedCorners()
    }

    // MARK: - Configure
    func configure(name: String, email: String) {
        nameLabel.text = name
        nameTextField.text = name
        emailLabel.text = email
    }

    func updateEditingState() {
        toggleNameEditing(isEditingName)
        updateEditButtonIcon(isEditingName)

        if isEditingName {
            nameTextField.becomeFirstResponder()
        } else {
            finalizeNameEditing()
        }
    }

    private func toggleNameEditing(_ isEditing: Bool) {
        nameLabel.isHidden = isEditing
        nameTextField.isHidden = !isEditing
    }

    private func updateEditButtonIcon(_ isEditing: Bool) {
        let editIcon: UIImage = isEditing ? .appIcon(.checkmarkCircle)! : .appIcon(.squareAndPencil)!
        editButton.setImage(editIcon, for: .normal)
    }

    private func finalizeNameEditing() {
        guard let newName = nameTextField.text, !newName.isEmpty else { return }
        nameLabel.text = newName
        nameTextField.resignFirstResponder()
        delegate?.didUpdateName(newName)
    }

    @objc private func didTapEditButton() {
        isEditingName.toggle()
    }

    @objc private func textFieldEditingChanged() {
        nameLabel.text = nameTextField.text
    }
}

// MARK: - Setup UI
private extension ProfileHeaderView {
    private func setupUI() {
        self.backgroundColor = .mainColor
        self.clipsToBounds = true
        setupAppBar()
        setupAvatarImageView()
        setupNameLabel()
        setupNameTextField()
        setupEmailLabel()
        setupEditButton()
    }

    private func setupAppBar() {
        appBar = AppBar(type: .profile)
        addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
    }

    private func setupAvatarImageView() {
        avatarImageView = UIImageView()
        avatarImageView.image = .appIcon(.personCircle)
        avatarImageView.tintColor = .white
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.clipsToBounds = true
        addSubview(avatarImageView)

        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.width.height.equalTo(UIHelper.dynamicHeight(80))
        }
    }

    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = LocalizationManager.shared.localized(for: .loading)
        nameLabel.textColor = .white
        nameLabel.font = .dynamicFont(size: 24, weight: .bold)
        addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top).offset(UIHelper.dynamicHeight(8))
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-60)
        }
    }

    private func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.textColor = .black
        nameTextField.font = .dynamicFont(size: 24, weight: .bold)
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 8
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nameTextField.leftViewMode = .always
        nameTextField.borderStyle = .none
        nameTextField.isHidden = true
        nameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        addSubview(nameTextField)

        nameTextField.snp.makeConstraints { make in
            make.edges.equalTo(nameLabel)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }
    }

    private func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = LocalizationManager.shared.localized(for: .loading)
        emailLabel.textColor = .white
        emailLabel.font = .dynamicFont(size: 16, weight: .medium)
        addSubview(emailLabel)

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(UIHelper.dynamicHeight(4))
            make.leading.trailing.equalTo(nameLabel)
        }
    }

    private func setupEditButton() {
        editButton = UIButton()
        editButton.setImage(.appIcon(.squareAndPencil), for: .normal)
        editButton.tintColor = .white
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        addSubview(editButton)

        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(UIHelper.dynamicHeight(30))
        }
    }

    private func applyRoundedCorners() {
        let cornerRadii = CGSize(width: 16, height: 16)
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: cornerRadii
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
