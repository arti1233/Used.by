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

class PickerVC: BaseViewController {
    
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
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private var realmServise: RealmServiceProtocol!
    var isCapacityPicker = true
    private var arrayInt = [Int] (10...90)
    private var arrayCapacity: [Double] = []
    private var arrayYear = [Int] (1970...2022)
    private var firstResultCapacity: Double = 0
    private var secondResultCapacity: Double = 0
    private var firstYear: Int = 0
    private var secondYear: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        view.addSubview(titleName)
        view.addSubview(acceptButton)
        view.addSubview(closeButton)
        view.addSubview(picker)
        arrayInt.forEach({arrayCapacity.append(Double($0) / 10)})
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        addElements()
    }
    
    @objc fileprivate func closeVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc fileprivate func acceptWithChoise(_ sender: UIButton) {
        isCapacityPicker ?  addCapacityRange(first: firstResultCapacity, second: secondResultCapacity) : addYearRange(first: firstYear, second: secondYear)
        dismiss(animated: true)
    }
// MARK: Metods
    func changeTitleName(name: String) {
        titleName.text = name
    }
    
    private func addYearRange(first: Int, second: Int) {
        realmServise.addObjectInSearchSetting(yearOfProductionMin: description.min(first, second))
        realmServise.addObjectInSearchSetting(yearOfProductionMax: description.max(first, second))
       
    }
    
    private func addCapacityRange(first: Double, second: Double) {
        realmServise.addObjectInSearchSetting(engineCapacityMin: description.min(first, second))
        realmServise.addObjectInSearchSetting(engineCapacityMax: description.max(first, second))
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

extension PickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        isCapacityPicker ? arrayCapacity.count : arrayYear.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        isCapacityPicker ? "\(arrayCapacity[row]) L" : "\(arrayYear[row])"
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


