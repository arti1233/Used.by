//
//  PickerCapacityViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 22.08.22.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class PickerCapacityViewController: BaseViewController {
    
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .left
        titleName.text = "Model"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
    
    private lazy var acceptButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .myCustomPurple
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("Accept", for: .normal)
        button.addTarget(self, action: #selector(acceptWithChoise), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .myCustomPurple
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var picker: UIPickerView = {
        var picker = UIPickerView()
        return picker
    }()
    
    var realmServise: RealmServiceProtocol!
    var isCapacityPicker = true
    var arrayInt = [Int] (10...90)
    var arrayCapacity: [Double] = []
    var arrayYear = [Int] (1970...2022)
    var firstResultCapacity: Double?
    var secondResultCapacity: Double?
    var firstYear: Int?
    var secondYear: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        view.addSubview(titleName)
        view.addSubview(acceptButton)
        view.addSubview(closeButton)
        view.addSubview(picker)
        
        picker.dataSource = self
        picker.delegate = self
        
        arrayInt.forEach({arrayCapacity.append(Double($0) / 10)})
        print(arrayCapacity)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        addElements()
    }
    
    @objc fileprivate func closeVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc fileprivate func acceptWithChoise(_ sender: UIButton) {
        if isCapacityPicker {
            addCapacityRange(first: firstResultCapacity, second: secondResultCapacity)
            dismiss(animated: true)
        } else {
            addYearRange(first: firstYear, second: secondYear)
            dismiss(animated: true)
        }
    }
// MARK: Metods
    func changeTitleName(name: String) {
        titleName.text = name
    }
    
    func addYearRange(first: Int!, second: Int!) {
        guard let first = first, let second = second else { return }
        if first >= second {
            realmServise.addObjectInSearchSetting(yearOfProductionMin: second)
            realmServise.addObjectInSearchSetting(yearOfProductionMax: first)
        } else {
            realmServise.addObjectInSearchSetting(yearOfProductionMin: first)
            realmServise.addObjectInSearchSetting(yearOfProductionMax: second)
        }
    }
    
    func addCapacityRange(first: Double!, second: Double!) {
        guard let first = first, let second = second else { return }
        if first >= second {
            realmServise.addObjectInSearchSetting(engineCapacityMin: second)
            realmServise.addObjectInSearchSetting(engineCapacityMax: first)
        } else {
            realmServise.addObjectInSearchSetting(engineCapacityMin: first)
            realmServise.addObjectInSearchSetting(engineCapacityMax: second)
        }
    }
    
    private func addElements() {
        
        titleName.snp.makeConstraints{
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(40)
            $0.centerY.equalTo(titleName.snp.centerY)
            closeButton.layer.cornerRadius = 40 / 2
        }
        
        acceptButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.height.equalTo(40)
        }
        
        picker.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleName.snp.bottom).inset(16)
            $0.height.equalTo(300)
        }
        
    }
}

extension PickerCapacityViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isCapacityPicker {
            return arrayCapacity.count
        } else {
            return arrayYear.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isCapacityPicker {
            if component == 0 {
                return "\(arrayCapacity[row]) L"
            } else {
                return "\(arrayCapacity[row]) L"
            }
        } else {
            if component == 0 {
                return "\(arrayYear[row])"
            } else {
                return "\(arrayYear[row])"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isCapacityPicker {
            if component == 0 {
                firstResultCapacity = arrayCapacity[row]
            } else {
                secondResultCapacity = arrayCapacity[row]
            }
        } else {
            if component == 0 {
                firstYear = arrayYear[row]
            } else {
                secondYear = arrayYear[row]
            }
        }
    }
    
}


