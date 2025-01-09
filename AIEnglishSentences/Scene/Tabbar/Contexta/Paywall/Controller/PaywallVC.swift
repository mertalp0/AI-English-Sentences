//
//  PaywallVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 7.01.2025.
//

import BaseMVVMCKit
import SnapKit
import UIKit
import RevenueCat

final class PaywallVC: BaseViewController<PaywallCoordinator, PaywallViewModel> {
    
    private let backButton = UIButton()
    private let purchaseButton = UIButton()
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private var packages: [Package] = []
    private var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchPackages()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.lightGray
        
        // Title Label
        titleLabel.text = "Unlock Premium"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        // Subtitle Label
        subtitleLabel.text = "Get access to all features with a subscription."
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .darkGray
        view.addSubview(subtitleLabel)
        
        // Back Button
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .systemBlue
        backButton.addTarget(self, action: #selector(onBackButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        // Purchase Button
        purchaseButton.setTitle("Subscribe Now", for: .normal)
        purchaseButton.setTitleColor(.white, for: .normal)
        purchaseButton.backgroundColor = UIColor.systemBlue
        purchaseButton.layer.cornerRadius = 25
        purchaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        purchaseButton.addTarget(self, action: #selector(onPurchaseButtonTapped), for: .touchUpInside)
        view.addSubview(purchaseButton)
        
        // TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(PaywallCell.self, forCellReuseIdentifier: "PackageCell")
        view.addSubview(tableView)
        
        // Constraints with SnapKit
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(purchaseButton.snp.top).offset(-16)
        }
        
        purchaseButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
    private func fetchPackages() {
        viewModel.fetchPackages { [weak self] packages in
            guard let self = self else { return }
            self.packages = packages ?? []
            self.tableView.reloadData()
        }
    }
    
    @objc private func onBackButtonTapped() {
        coordinator?.back()
    }
    
    @objc private func onPurchaseButtonTapped() {
        guard let selectedIndexPath = selectedIndexPath else { return }
        let selectedPackage = packages[selectedIndexPath.row]
        viewModel.purchase(package: selectedPackage) { success in
            if success {
                print("Purchase successful")
                self.coordinator?.back()
            } else {
                print("Purchase failed")
            }
        }
    }
}

extension PaywallVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageCell", for: indexPath) as! PaywallCell
        let package = packages[indexPath.row]
        cell.configure(with: package, isSelected: selectedIndexPath == indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
    }
}

// Custom TableView Cell
final class PaywallCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    
    func configure(with package: Package, isSelected: Bool) {
        titleLabel.text = package.storeProduct.localizedTitle
        priceLabel.text = package.storeProduct.localizedPriceString
        
        setupUI(isSelected: isSelected)
    }
    
    private func setupUI(isSelected: Bool) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = isSelected ? .systemBlue : .black
        
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.textColor = isSelected ? .systemBlue : .systemGray
        
        contentView.backgroundColor = isSelected ? UIColor.systemGray5 : .white
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = isSelected ? 2 : 0
        contentView.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.bottom.trailing.equalToSuperview().inset(16)
        }
    }
}
