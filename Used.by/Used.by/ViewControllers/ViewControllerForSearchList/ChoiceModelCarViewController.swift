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

class ChoiceModelCarViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .purple
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
    
    var carModel: CarBrend!
    var realmServise: RealmServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        view.addSubview(titleName)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BrendCarCell.self, forCellReuseIdentifier: BrendCarCell.key)
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
    func changeTitleName(name: String) {
        titleName.text = name
    }
}





extension ChoiceModelCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carModel = carModel else { return 0 }
        return carModel.modelSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrendCarCell.key) as? BrendCarCell,
              let carModel = carModel else { return UITableViewCell() }
        cell.updateConstraints()
        cell.changeNameCell(name: carModel.modelSeries[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let carModel = carModel else { return }
        realmServise.addObjectInSearchSetting(carBrend: carModel.name)
        realmServise.addObjectInSearchSetting(carModel: carModel.modelSeries[indexPath.row].name)
        dismiss(animated: true)
    }
    
}
