//
//  ChoiceModelCarViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 17.08.22.
//

import UIKit
import Foundation
import SnapKit

class BrendCarVC: BaseViewController {

    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .center
        titleName.text = "Brend Car"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BrendCarCell.self, forCellReuseIdentifier: BrendCarCell.key)
        return tableView
    }()
    
    private var realmServise: RealmServiceProtocol!
    
    var carBrend: [CarBrend] = []
    var isSearch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        addElements()
        offLargeTitle()
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
    
    private func addElements() {
        view.addSubview(titleName)
        view.addSubview(tableView)
    }
}

extension BrendCarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carBrend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrendCarCell.key) as? BrendCarCell else { return UITableViewCell() }
        cell.updateConstraints()
        cell.changeNameCell(name: carBrend[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carModel = carBrend[indexPath.row]
        let VC = ModelCarVC()
        VC.carModel = carModel.modelSeries
        VC.isSearch = isSearch
        if isSearch {
            realmServise.addObjectInSearchSetting(carModel: "")
            realmServise.addObjectInSearchSetting(carBrend: carModel.name)
        } else {
            realmServise.addAdsParams(carBrendName: carModel.name)
        }
        VC.changeTitleName(name: carModel.name)
        navigationController?.pushViewController(VC, animated: true)
    }
}
