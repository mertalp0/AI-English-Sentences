//
//  ResultVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import UIKit
import BaseMVVMCKit

final class ResultVC: BaseViewController<ResultCoordinator, ResultViewModel>{
    
    //MARK: - Properties
    var generateModel: GenerateModel?
    
    //MARK: - UI Elements
    private var pageTitle: UILabel!
    private var backButton: CustomButton!
    private weak var saveSentencesButton: CustomButton?
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupActions()
    }
    
    private func setupUI(){
        
        //Page Title
        pageTitle = UILabel()
        pageTitle.text = String(describing: type(of: self))
        pageTitle.textColor = .black
        
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 10)
        }
        
        //Back Button
        backButton = CustomButton()
        backButton.configure(title: "Back", backgroundColor: .systemGreen, textColor: .white)
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-250)
        }
        
        // Save Sentences Button
        let saveBtn = CustomButton()
        saveBtn.configure(title: "Save Sentences", backgroundColor: .gray, textColor: .white)
        view.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        saveSentencesButton = saveBtn
        setupTableView()
        
    }
    
    private func setupTableView(){
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom)
            make.bottom.equalTo(backButton.snp.top)
            make.left.right.equalToSuperview()
        }
        
    }
    
    private func setupActions(){
        backButton.addTarget(self, action: #selector(onTapBack) , for: .touchUpInside)
        saveSentencesButton?.addTarget(self, action: #selector(onTapSaveSentences), for: .touchUpInside)
        
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ResultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return generateModel?.sentences.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = generateModel?.sentences[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - Alert
extension ResultVC {
    
    private func showSuccesAlert(){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Registration successful", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK" , style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


//MARK: - Actions
extension ResultVC {
    
    @objc func onTapBack(){
        coordinator?.back()
    }
    
    @objc private func onTapSaveSentences() {
        guard let button = saveSentencesButton else { return }
        guard let generateModel = self.generateModel else {return}
        print("Save Sentences button tapped: \(button)")
        
        viewModel.saveGenerateModel(generateModel: generateModel) { isSucces in
            
            if isSucces{
                self.showSuccesAlert()
                DispatchQueue.main.async {
                    button.backgroundColor = .green
                }
            }
        }
    }
}

