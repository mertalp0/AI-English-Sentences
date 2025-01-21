//
//  GenerateSentenceVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class ContextaViewController: BaseViewController<ContextaCoordinator, ContextaViewModel> {

    // MARK: - Properties
    let categoryCell: [CellType] = [.professional, .personal, .educational]

    // MARK: - UI Elements
    private var appBar: AppBar!
    private var subTitle: UILabel!
    private var categoriesTitle: UILabel!
    private var categoryTableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI Setup
private extension ContextaViewController {

   private func setupUI() {
        view.backgroundColor = .white
        setupAppBar()
        setupSubTitle()
        setupCategoriesTitle()
        setupTableView()
    }

    private func setupAppBar() {
        appBar = AppBar(type: .contexta)
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
    }

    private func setupSubTitle() {
        subTitle = UILabel()
        subTitle.text = .localized(for: .contextaSubtitle)
        subTitle.textColor = .mainColor
        subTitle.font = .dynamicFont(size: 16, weight: .medium)
        subTitle.textAlignment = .center
        view.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(5))
        }
    }

    private func setupCategoriesTitle() {
        categoriesTitle = UILabel()
        categoriesTitle.text = .localized(for: .contextaCategoriesTitle)
        categoriesTitle.textColor = .black
        categoriesTitle.font = .dynamicFont(size: 24, weight: .medium)
        categoriesTitle.textAlignment = .center
        view.addSubview(categoriesTitle)
        categoriesTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(subTitle.snp.bottom).offset(UIHelper.dynamicHeight(25))
        }
    }

    private func setupTableView() {
        categoryTableView = UITableView()
        categoryTableView.backgroundColor = .white
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        view.addSubview(categoryTableView)
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesTitle.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}
