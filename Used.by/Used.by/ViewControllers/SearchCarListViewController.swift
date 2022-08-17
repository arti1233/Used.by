//
//  searchCarListViewController .swift
//  Used.by
//
//  Created by Artsiom Korenko on 14.08.22.
//

import Foundation
import UIKit
import SnapKit


class SearchCarListViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.isEditing = false
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
        title = "Parametrs"
        view.addSubview(tableView)
        view.addSubview(searchButton)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BasicCellForSearchList.self, forCellReuseIdentifier: BasicCellForSearchList.key)
        tableView.register(CellForRequestPicker.self, forCellReuseIdentifier: CellForRequestPicker.key)
        

    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addElementsForView()
        
    }

    @objc private func searchButtonPressed(sender: UIButton) {
        
    }
    
// MARK: Metods for constreint
    
    private func addElementsForView() {
        
        tableView.snp.makeConstraints {
            guard let tabBar = tabBarController?.tabBar.frame.height else { return }
            $0.bottom.equalToSuperview().inset(tabBar)
            $0.trailing.leading.equalToSuperview().inset(0)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(0)
        }

        searchButton.snp.makeConstraints {
            guard let tabBar = tabBarController?.tabBar.frame.height else { return }
            $0.bottom.equalToSuperview().inset(tabBar + 16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
// MARK: Metods
    
    private func selectionForCellTableView(indexPath: IndexPath, isSelected: Bool){
        if let cell = tableView.dequeueReusableCell(withIdentifier: BasicCellForSearchList.key) as? BasicCellForSearchList {
            cell.setSelectedAttribute(isSelected: isSelected)
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
        guard let cellForRequesPicker = tableView.dequeueReusableCell(withIdentifier: CellForRequestPicker.key) as? CellForRequestPicker,
              let basicCell = tableView.dequeueReusableCell(withIdentifier: BasicCellForSearchList.key) as? BasicCellForSearchList else { return UITableViewCell() }
        cellForRequesPicker.layoutSubviews()
        basicCell.layoutSubviews()
        
        switch CreateSections.allCases[indexPath.section] {
        case .modelCars:
            switch ModelCars.allCases[indexPath.row] {
            case .carBrend:
                cellForRequesPicker.changeFieldName(name: ModelCars.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .carModel:
                cellForRequesPicker.changeFieldName(name: ModelCars.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .generation:
                cellForRequesPicker.changeFieldName(name: ModelCars.allCases[indexPath.row].description)
                return cellForRequesPicker
            }
        case .techSpecifications:
            switch TechSpecifications.allCases[indexPath.row] {
            case .yearOfProduction:
                cellForRequesPicker.changeFieldName(name: TechSpecifications.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .cost:
                cellForRequesPicker.changeFieldName(name: TechSpecifications.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .engineСapacity:
                cellForRequesPicker.changeFieldName(name: TechSpecifications.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .gearbox:
                cellForRequesPicker.changeFieldName(name: TechSpecifications.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .typeEngine:
                cellForRequesPicker.changeFieldName(name: TechSpecifications.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .typeDrive:
                cellForRequesPicker.changeFieldName(name: TechSpecifications.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .bodyType:
                cellForRequesPicker.changeFieldName(name: TechSpecifications.allCases[indexPath.row].description)
                return cellForRequesPicker
            }
        case .seller:
            switch Seller.allCases[indexPath.row] {
            case .area:
                cellForRequesPicker.changeFieldName(name: Seller.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .city:
                cellForRequesPicker.changeFieldName(name: Seller.allCases[indexPath.row].description)
                return cellForRequesPicker
            }
        case .airСonditions:
            switch AirСonditions.allCases[indexPath.row] {
            case .mileage:
                cellForRequesPicker.changeFieldName(name: AirСonditions.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .conditionAuto:
                cellForRequesPicker.changeFieldName(name: AirСonditions.allCases[indexPath.row].description)
                return cellForRequesPicker
            }
        case .exterior:
            switch Exterior.allCases[indexPath.row] {
            case .color:
                cellForRequesPicker.changeFieldName(name: Exterior.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .wheels:
                basicCell.changeNameCell(name: Exterior.allCases[indexPath.row].description)
                return basicCell
            case .roofRails:
                basicCell.changeNameCell(name: Exterior.allCases[indexPath.row].description)
                return basicCell
            case .trailerCoupling:
                basicCell.changeNameCell(name: Exterior.allCases[indexPath.row].description)
                return basicCell
            }
        case .securitySystems:
            switch SecuritySystems.allCases[indexPath.row] {
            case .abs:
                basicCell.changeNameCell(name: SecuritySystems.allCases[indexPath.row].description)
                return basicCell
            case .esp:
                basicCell.changeNameCell(name: SecuritySystems.allCases[indexPath.row].description)
                return basicCell
            case .asr:
                basicCell.changeNameCell(name: SecuritySystems.allCases[indexPath.row].description)
                return basicCell
            case .immobilizer:
                basicCell.changeNameCell(name: SecuritySystems.allCases[indexPath.row].description)
                return basicCell
            case .alarmSystem:
                basicCell.changeNameCell(name: SecuritySystems.allCases[indexPath.row].description)
                return basicCell
            }
        case .assistanceSystems:
            switch AssistanceSystems.allCases[indexPath.row] {
            case .rainSensor:
                basicCell.changeNameCell(name: AssistanceSystems.allCases[indexPath.row].description)
                return basicCell
            case .parkCamera:
                basicCell.changeNameCell(name: AssistanceSystems.allCases[indexPath.row].description)
                return basicCell
            case .parktronic:
                basicCell.changeNameCell(name: AssistanceSystems.allCases[indexPath.row].description)
                return basicCell
            case .blis:
                basicCell.changeNameCell(name: AssistanceSystems.allCases[indexPath.row].description)
                return basicCell
            }
        case .airbag:
            switch Airbag.allCases[indexPath.row] {
            case .front:
                basicCell.changeNameCell(name: Airbag.allCases[indexPath.row].description)
                return basicCell
            case .side:
                basicCell.changeNameCell(name: Airbag.allCases[indexPath.row].description)
                return basicCell
            case .back:
                basicCell.changeNameCell(name: Airbag.allCases[indexPath.row].description)
                return basicCell
            }
        case .interior:
            switch Interior.allCases[indexPath.row] {
                
            case .colorInterior:
                cellForRequesPicker.changeFieldName(name: Interior.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .materialInterior:
                cellForRequesPicker.changeFieldName(name: Interior.allCases[indexPath.row].description)
                return cellForRequesPicker
            case .panoramicRoof:
                basicCell.changeNameCell(name: Interior.allCases[indexPath.row].description)
                return basicCell
            case .hatch:
                basicCell.changeNameCell(name: Interior.allCases[indexPath.row].description)
                return basicCell
            case .sevenSeatVersion:
                basicCell.changeNameCell(name: Interior.allCases[indexPath.row].description)
                return basicCell
            }
        case .comfort:
            switch Comfort.allCases[indexPath.row] {
            case .automaticStart:
                basicCell.changeNameCell(name: Comfort.allCases[indexPath.row].description)
                return basicCell
            case .cruiseControl:
                basicCell.changeNameCell(name: Comfort.allCases[indexPath.row].description)
                return basicCell
            case .multiWheel:
                basicCell.changeNameCell(name: Comfort.allCases[indexPath.row].description)
                return basicCell
            case .electricSeat:
                basicCell.changeNameCell(name: Comfort.allCases[indexPath.row].description)
                return basicCell
            case .electricWindowFront:
                basicCell.changeNameCell(name: Comfort.allCases[indexPath.row].description)
                return basicCell
            case .electricWindowBack:
                basicCell.changeNameCell(name: Comfort.allCases[indexPath.row].description)
                return basicCell
            }
        case .climate:
            switch Climate.allCases[indexPath.row] {
            case .climateControl:
                basicCell.changeNameCell(name: Climate.allCases[indexPath.row].description)
                return basicCell
            case .airCondition:
                basicCell.changeNameCell(name: Climate.allCases[indexPath.row].description)
                return basicCell
            }
        case .headlights:
            switch Headlights.allCases[indexPath.row] {
            case .xenon:
                basicCell.changeNameCell(name: Headlights.allCases[indexPath.row].description)
                return basicCell
            case .fog:
                basicCell.changeNameCell(name: Headlights.allCases[indexPath.row].description)
                return basicCell
            case .led:
                basicCell.changeNameCell(name: Headlights.allCases[indexPath.row].description)
                return basicCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = CreateSections.allCases[indexPath.section]

        switch section {
        case .modelCars:
            switch ModelCars.allCases[indexPath.row] {
            case .carBrend:
                let VC = ChoiceModelCarViewController()
                navigationController?.pushViewController(VC, animated: true)
            case .carModel:
                print("OK")
            case .generation:
                print("OK")
            }
        case .techSpecifications:
            print("OK")
        case .seller:
            print("OK")
        case .airСonditions:
            print("OK")
        case .exterior:
            print("OK")
        case .securitySystems:
            switch SecuritySystems.allCases[indexPath.row] {
            case .abs:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .esp:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .asr:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .immobilizer:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .alarmSystem:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            }
        case .assistanceSystems:
            switch AssistanceSystems.allCases[indexPath.row] {
            case .rainSensor:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .parkCamera:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .parktronic:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .blis:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            }
        case .airbag:
            switch Airbag.allCases[indexPath.row] {
            case .front:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .side:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .back:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            }
        case .interior:
            print("OK")
        case .comfort:
            switch Comfort.allCases[indexPath.row] {
            case .automaticStart:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .cruiseControl:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .multiWheel:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .electricSeat:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .electricWindowFront:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .electricWindowBack:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            }
        case .climate:
            switch Climate.allCases[indexPath.row] {
            case .climateControl:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .airCondition:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            }
        case .headlights:
            switch Headlights.allCases[indexPath.row] {
            case .xenon:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .fog:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            case .led:
                selectionForCellTableView(indexPath: indexPath, isSelected: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let section = CreateSections.allCases[indexPath.section]
        
        switch section {
        case .modelCars:
            print("OK")
        case .techSpecifications:
            print("OK")
        case .seller:
            print("OK")
        case .airСonditions:
            print("OK")
        case .exterior:
            print("OK")
        case .securitySystems:
            switch SecuritySystems.allCases[indexPath.row] {
            case .abs:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .esp:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .asr:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .immobilizer:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .alarmSystem:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            }
        case .assistanceSystems:
            switch AssistanceSystems.allCases[indexPath.row] {
            case .rainSensor:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .parkCamera:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .parktronic:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .blis:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            }
        case .airbag:
            switch Airbag.allCases[indexPath.row] {
            case .front:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .side:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .back:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            }
        case .interior:
            print("OK")
        case .comfort:
            switch Comfort.allCases[indexPath.row] {
            case .automaticStart:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .cruiseControl:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .multiWheel:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .electricSeat:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .electricWindowFront:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .electricWindowBack:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            }
        case .climate:
            switch Climate.allCases[indexPath.row] {
            case .climateControl:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .airCondition:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            }
        case .headlights:
            switch Headlights.allCases[indexPath.row] {
            case .xenon:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .fog:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            case .led:
                selectionForCellTableView(indexPath: indexPath, isSelected: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        CreateSections.allCases[section].title
    }
}
