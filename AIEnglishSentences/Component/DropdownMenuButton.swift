//
//  DropdownMenuButton.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import SnapKit

final class DropdownMenuButton: UIView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    private let title: String
    private let options: [String]
    private var selectedOption: String? {
        didSet {
            selectedOptionLabel.text = selectedOption
        }
    }
    var onDropdownTapped: (() -> Void)?

    
    private let titleLabel = UILabel()
    private let selectedOptionLabel = UILabel()
    private let dropdownIcon = UIImageView()
    private var tableView: UITableView!
    private var tableViewHeightConstraint: NSLayoutConstraint!
    private var isExpanded = false
    
    var onOptionSelected: ((String) -> Void)?
    
    // MARK: - Initialization
    init(title: String, options: [String]) {
        self.title = title
        self.options = options
        super.init(frame: .zero)
        setupViews()
        selectedOption = options.first
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupTableView()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .darkGray
        
        selectedOptionLabel.text = options.first
        selectedOptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        selectedOptionLabel.textColor = .black
        
        dropdownIcon.image = UIImage(systemName: "chevron.down")
        dropdownIcon.tintColor = .gray
        dropdownIcon.contentMode = .scaleAspectFit
        
        addSubview(titleLabel)
        addSubview(selectedOptionLabel)
        addSubview(dropdownIcon)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        selectedOptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        dropdownIcon.snp.makeConstraints { make in
            make.centerY.equalTo(selectedOptionLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(20)
        }
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleDropdown)))
    }
    
    private func setupTableView() {
        guard let superview = self.superview else { return }
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemGray4.cgColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        tableView.isHidden = true
        
        superview.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16)
        ])
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint.isActive = true
    }
    
    // MARK: - Toggle Dropdown
    @objc private func toggleDropdown() {
        onDropdownTapped?()

        guard let tableView = tableView, let superview = self.superview else { return }
        
        isExpanded.toggle()

        if isExpanded {
            superview.bringSubviewToFront(tableView)
            tableView.isHidden = false
            tableViewHeightConstraint.constant = CGFloat(options.count * 44)
            dropdownIcon.transform = CGAffineTransform(rotationAngle: .pi)
        } else {
            tableViewHeightConstraint.constant = 0
            dropdownIcon.transform = .identity
        }

        UIView.animate(withDuration: 0.3, animations: {
            superview.layoutIfNeeded()
        }) { _ in
            if !self.isExpanded {
                tableView.isHidden = true
            }
        }
    }
    
    // MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
      
        if options[indexPath.row] == selectedOption {
            cell.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
            cell.textLabel?.textColor = .systemBlue
        } else {
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption = options[indexPath.row]
        onOptionSelected?(selectedOption ?? "")
        toggleDropdown()
        tableView.reloadData()
    }
}
