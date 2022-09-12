//
//  ChoiceModelCarViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 20.08.22.
//

import Foundation
import UIKit
import Foundation
import SnapKit

class ModelCarVC: BaseViewController {

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BrendCarCell.self, forCellReuseIdentifier: BrendCarCell.key)
        return tableView
    }()
    
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .center
        titleName.text = "Model"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
    
    var carModel: [BrendModel] = []
    private var realmServise: RealmServiceProtocol!
    var isSearch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        view.addSubview(titleName)
        view.addSubview(tableView)
        offLargeTitle()
        if isSearch {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Accept", style: .plain, target: self, action: #selector(resetButtonPressed(sender:)))]
        }
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addElementsForView()
    }
    
    private func addElementsForView() {
        titleName.snp.makeConstraints{
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(0)
            $0.top.equalToSuperview().inset(65)
        }
    }
    
//MARK: Metod
    @objc private func resetButtonPressed(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func changeTitleName(name: String) {
        titleName.text = name
    }
}

extension ModelCarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrendCarCell.key) as? BrendCarCell else { return UITableViewCell() }
        cell.updateConstraints()
        cell.changeNameCell(name: carModel[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearch {
            realmServise.addObjectInSearchSetting(carModel: carModel[indexPath.row].name)
        } else {
            realmServise.addAdsParams(carModelName: carModel[indexPath.row].name)
        }
        dismiss(animated: true)
    }
    
}
