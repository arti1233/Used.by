//
//  ChooseParams.swift
//  Used.by
//
//  Created by Artsiom Korenko on 1.09.22.
//

import Foundation
import UIKit
import Foundation
import SnapKit

enum ChooseParamsEnum: CaseIterable {
    case typeEngine
    case typeDrive
    case gearbox
    case condition
    
    var title: String {
        switch self {
        case .typeEngine:
            return "Type engine"
        case .typeDrive:
            return "Type drive"
        case .gearbox:
            return "Gearbox"
        case .condition:
            return "Condition"
        }
    }
}

class ChooseParamsVC: BaseViewController {

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellForMileage.self, forCellReuseIdentifier: CellForMileage.key)
        return tableView
    }()
    
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .left
        titleName.text = "Model"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
 
    private var realmServise: RealmServiceProtocol!
    private var arrayElements: [ListItem] = []
    var parametrs = ChooseParamsEnum.typeEngine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        addElements()
        titleName.text = parametrs.title
        switch parametrs {
        case .typeEngine:
            arrayElements = TypeEngime.allCases.enumerated().map({ListItem(title: $0.element.title, isSelected: false, index: $0.offset)})
        case .typeDrive:
            arrayElements = TypeOfDrive.allCases.enumerated().map({ListItem(title: $0.element.title, isSelected: false, index: $0.offset)})
        case .gearbox:
            arrayElements = GearBox.allCases.enumerated().map({ListItem(title: $0.element.title, isSelected: false, index: $0.offset)})
        case .condition:
            arrayElements = ConditionsForAddAds.allCases.enumerated().map({ListItem(title: $0.element.title, isSelected: false, index: $0.offset)})
        }
    }
    
    @objc fileprivate func closeVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint()
    }
    

    
//MARK: Metod
    func changeTitleName(name: String) {
        titleName.text = name
    }
    
    func convertingIndexToElement(index: Int) -> Int {
        return 1 << index
    }
    
    func addResultInRealm(params: ChooseParamsEnum, indexPath: Int) {
        switch params {
        case .typeEngine:
            realmServise.addAdsParams(typeEngine: convertingIndexToElement(index: indexPath))
        case .typeDrive:
            realmServise.addAdsParams(typeDrive: convertingIndexToElement(index: indexPath))
        case .gearbox:
            realmServise.addAdsParams(gearbox: convertingIndexToElement(index: indexPath))
        case .condition:
            realmServise.addAdsParams(condition: convertingIndexToElement(index: indexPath))
        }
    }
     
    
//MARK: Metod for constreint
    private func addConstreint() {
        titleName.snp.makeConstraints{
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
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

extension ChooseParamsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForMileage.key) as? CellForMileage else { return UITableViewCell() }
        cell.changeNameCell(name: arrayElements[indexPath.row].title)
        cell.updateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addResultInRealm(params: parametrs, indexPath: indexPath.row)
        dismiss(animated: true)
    }
}
