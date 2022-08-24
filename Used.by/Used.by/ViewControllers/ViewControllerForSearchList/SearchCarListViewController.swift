//
//  searchCarListViewController .swift
//  Used.by
//
//  Created by Artsiom Korenko on 14.08.22.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift


class SearchCarListViewController: BaseViewController {

    var realmServise: RealmServiceProtocol!
    var alamofireProvider: RestAPIProviderProtocol!
    var searchSettinmgItems: Results<SearchSetting>!
    private var notificationToken: NotificationToken?
    var carBrend: [CarBrend]?
    
    var typeEngineStruct = TypeEngimeStruct()
    var typeDriveStruct = TypeOfDriveStruct()
    var gearBoxStruct = GearBoxStruct()
    var conditionsStruct = ConditionStruct()
    let realm = try! Realm()
    
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .center
        titleName.text = "Parametrs"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        return tableView
    }()
    
    private lazy var searchButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        alamofireProvider = AlamofireProvider()
        view.addSubview(titleName)
        view.addSubview(tableView)
        view.addSubview(searchButton)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CellForTouch.self, forCellReuseIdentifier: CellForTouch.key)
        tableView.register(CellForRequestView.self, forCellReuseIdentifier: CellForRequestView.key)
        tableView.allowsMultipleSelection = true
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        getCarbrend()
    
        searchSettinmgItems = realmServise.getListSearchSetting()
        print(searchSettinmgItems)
        if searchSettinmgItems == nil {
            realmServise.resetSearchSetting()
            searchSettinmgItems = realmServise.getListSearchSetting()
        }
        
        guard let items = searchSettinmgItems.first else { return }
        notificationToken = items.observe{ [weak self] change in
            guard let self = self else { return }
            switch change {
            case .change(_, _):
                self.searchSettinmgItems = self.realmServise.getListSearchSetting()
                self.tableView.reloadData()
                print(self.searchSettinmgItems)
            default:
                break
            }
        }
        
//        var arrayName = ""
//        Headlights.allCases.forEach {
//            if selectedHead.contains($0.options) {
//                arrayName.append("\($0.description), ")
//            }
//        }
//        print(arrayName)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint()
        
    }

    @objc private func searchButtonPressed(sender: UIButton) {
        
    }
    
// MARK: Metods for constreint
    
    private func addConstreint() {
        
        titleName.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(0)
            $0.top.equalToSuperview().inset(65)
        }

        searchButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
// MARK: Metods
    
    private func getCarbrend() {
        alamofireProvider.getCarBrendInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.carBrend = result
            case .failure:
                print("ERROR")
            }
        }
    }
}

extension SearchCarListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        CreateSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CreateSections.allCases[section].cellCount
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForTouch = tableView.dequeueReusableCell(withIdentifier: CellForTouch.key) as? CellForTouch,
              let cellForRequestView = tableView.dequeueReusableCell(withIdentifier: CellForRequestView.key) as? CellForRequestView,
              let items = searchSettinmgItems.first else { return UITableViewCell() }
        
        cellForTouch.updateConstraints()
        cellForRequestView.updateConstraints()
        cellForTouch.selectionStyle = .none
        cellForRequestView.selectionStyle = .none
        
        let section = CreateSections.allCases[indexPath.section]
        let modelCars = ModelCars.allCases
        let parametrs = Parametrs.allCases
        let typeEngine = TypeEngime.allCases
        let typeDrive = TypeOfDrive.allCases
        let gearBox = GearBox.allCases
        let conditions = Conditions.allCases
        
        
        switch section {
        case .modelCars:
            switch modelCars[indexPath.row] {
            case .carBrend:
                cellForRequestView.changeFieldName(name: modelCars[indexPath.row].title)
                cellForRequestView.changeResultLabel(name: items.carBrend)
                return cellForRequestView
            case .carModel:
                cellForRequestView.changeFieldName(name: modelCars[indexPath.row].title)
                cellForRequestView.changeResultLabel(name: items.carModel)
                return cellForRequestView
            }
        case .parametrs:
            switch parametrs[indexPath.row] {
            case .yearOfProduction:
                cellForRequestView.changeFieldName(name: parametrs[indexPath.row].title)
                if items.yearOfProductionMin != 0 || items.yearOfProductionMax != 0 {
                    cellForRequestView.changeResultLabel(name: "from \(items.yearOfProductionMin) to \(items.yearOfProductionMax)")
                }
                return cellForRequestView
            case .cost:
                cellForRequestView.changeFieldName(name: parametrs[indexPath.row].title)
                if items.costMin != 0 || items.costMax != 0 {
                    cellForRequestView.changeResultLabel(name: "from \(items.costMin) to \(items.costMax) USD")
                }
                return cellForRequestView
            case .engineСapacity:
                cellForRequestView.changeFieldName(name: parametrs[indexPath.row].title)
                if items.engineCapacityMin != 0 || items.engineCapacityMax != 0 {
                    cellForRequestView.changeResultLabel(name: "from \(items.engineCapacityMin) to \(items.engineCapacityMax)")
                }
                return cellForRequestView
            }
        case .typeEngine:
            cellForTouch.changeNameCell(name: typeEngine[indexPath.row].title)
            return cellForTouch
        case .typeDrive:
            cellForTouch.changeNameCell(name: typeDrive[indexPath.row].title)
            return cellForTouch
        case .gearbox:
            cellForTouch.changeNameCell(name: gearBox[indexPath.row].title)
            return cellForTouch
        case .conditions:
            switch conditions[indexPath.row] {
            case .mileage:
                cellForRequestView.changeFieldName(name: conditions[indexPath.row].title)
                if items.mileage != 0{
                    cellForRequestView.changeResultLabel(name: "from \(items.mileage) thousands km ")
                }
                return cellForRequestView
            case .new:
                cellForTouch.changeNameCell(name: conditions[indexPath.row].title)
                return cellForTouch
            case .used:
                cellForTouch.changeNameCell(name: conditions[indexPath.row].title)
                return cellForTouch
            case .crash:
                cellForTouch.changeNameCell(name: conditions[indexPath.row].title)
                return cellForTouch
            case .forParts:
                cellForTouch.changeNameCell(name: conditions[indexPath.row].title)
                return cellForTouch
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = CreateSections.allCases[indexPath.section]
        let modelCars = ModelCars.allCases
        let parametrs = Parametrs.allCases
        let typeEngine = TypeEngime.allCases
        let typeDrive = TypeOfDrive.allCases
        let gearBox = GearBox.allCases
        let conditions = Conditions.allCases
        
        switch section {
        case .modelCars:
            switch modelCars[indexPath.row] {
            case .carBrend:
                let vc = ChoiceBrendCarViewController()
                vc.carBrend = carBrend
                let navVC = UINavigationController(rootViewController: vc)
                present(navVC, animated: true)
            case .carModel:
                print("OK")
            }
        case .parametrs:
            switch parametrs[indexPath.row] {
            case .yearOfProduction:
                let vc = PickerCapacityViewController()
                vc.isCapacityPicker = false
                present(vc, animated: true)
            case .cost:
                let vc = ChooseCostViewController()
                vc.changeTitleName(name: "\(parametrs[indexPath.row].title) USD")
                present(vc, animated: true)
            case .engineСapacity:
                let vc = PickerCapacityViewController()
                vc.isCapacityPicker = true
                present(vc, animated: true)
            }
        case .typeEngine:
            typeEngineStruct.insert(typeEngine[indexPath.row].options)
            realmServise.addObjectInSearchSetting(typeEngine: typeEngineStruct.rawValue)
        case .typeDrive:
            typeDriveStruct.insert(typeDrive[indexPath.row].options)
            realmServise.addObjectInSearchSetting(typeDrive: typeDriveStruct.rawValue)
        case .gearbox:
            gearBoxStruct.insert(gearBox[indexPath.row].options)
            realmServise.addObjectInSearchSetting(gearbox: gearBoxStruct.rawValue)
        case .conditions:
            switch conditions[indexPath.row] {
            case .mileage:
                let vc = ChooseMileageViewController()
                vc.changeTitleName(name: conditions[indexPath.row].title)
                present(vc, animated: true)
            case .new:
                conditionsStruct.insert(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
            case .used:
                conditionsStruct.insert(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
            case .crash:
                conditionsStruct.insert(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
            case .forParts:
                conditionsStruct.insert(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
                print(searchSettinmgItems)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let section = CreateSections.allCases[indexPath.section]
        let modelCars = ModelCars.allCases
        let parametrs = Parametrs.allCases
        let typeEngine = TypeEngime.allCases
        let typeDrive = TypeOfDrive.allCases
        let gearBox = GearBox.allCases
        let conditions = Conditions.allCases
        
        switch section {
        case .modelCars:
            switch modelCars[indexPath.row] {
            case .carBrend:
                realmServise.addObjectInSearchSetting(carBrend: "")
            case .carModel:
                realmServise.addObjectInSearchSetting(carModel: "")
            }
        case .parametrs:
            switch parametrs[indexPath.row] {
            case .yearOfProduction:
                realmServise.addObjectInSearchSetting(yearOfProductionMin: 0)
                realmServise.addObjectInSearchSetting(yearOfProductionMax: 0)
            case .cost:
                realmServise.addObjectInSearchSetting(costMax: 0)
                realmServise.addObjectInSearchSetting(costMin: 0)
            case .engineСapacity:
                realmServise.addObjectInSearchSetting(engineCapacityMax: 0)
                realmServise.addObjectInSearchSetting(engineCapacityMin: 0)
            }
        case .typeEngine:
            typeEngineStruct.remove(typeEngine[indexPath.row].options)
            realmServise.addObjectInSearchSetting(typeEngine: typeEngineStruct.rawValue)
        case .typeDrive:
            typeDriveStruct.remove(typeDrive[indexPath.row].options)
            realmServise.addObjectInSearchSetting(typeDrive: typeDriveStruct.rawValue)
        case .gearbox:
            gearBoxStruct.remove(gearBox[indexPath.row].options)
            realmServise.addObjectInSearchSetting(gearbox: gearBoxStruct.rawValue)
        case .conditions:
            switch conditions[indexPath.row] {
            case .mileage:
                realmServise.addObjectInSearchSetting(mileage: 0)
            case .new:
                conditionsStruct.remove(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
            case .used:
                conditionsStruct.remove(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
            case .crash:
                conditionsStruct.remove(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
            case .forParts:
                conditionsStruct.remove(conditions[indexPath.row].options)
                realmServise.addObjectInSearchSetting(conditionAuto: conditionsStruct.rawValue)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        CreateSections.allCases[section].title
    }


}
