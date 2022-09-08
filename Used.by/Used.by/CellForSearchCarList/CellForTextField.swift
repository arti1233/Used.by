//
//  CellForPhoneNumber.swift
//  Used.by
//
//  Created by Artsiom Korenko on 28.08.22.
//

import Foundation
import UIKit
import SnapKit

// Enum for change target text field 
enum TargetTextField: CaseIterable {
    case year
    case capacity
    case cost
    case phoneNumber
    case mileage
}

class CellForTextField: UITableViewCell, UITextFieldDelegate {

    static let key = "CellForTextField"
    private var realmServise: RealmServiceProtocol!
    var targetTextField: TargetTextField!
    private var adsConfigure = AdsConfigure()
    
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var customTextField: CustomTextField = {
        var field = CustomTextField()
        field.font = UIFont.systemFont(ofSize: 21)
        field.keyboardType = .default
        field.delegate = self
        return field
    }()

//MARK: Override functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        realmServise = RealmService()
        addElements()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let target = targetTextField {
            changeTargetTextField(target: target)
        }
    }

    override func updateConstraints() {
        super.updateConstraints()
        if let target = targetTextField {
            changeTargetTextField(target: target)
        }
        addConstreint()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
// UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) else { return false }
        return true
    }
    
//MARK: Metods
    
    func changeTextField(text: String) {
        customTextField.text = text
    }
    
    private func changeTargetTextField(target: TargetTextField) {
        switch target {
        case .year:
            nameCellLabel.text = "Year"
            customTextField.placeholder = "Year of productions"
        case .capacity:
            nameCellLabel.text = "Capacity cm"
            nameCellLabel.font = UIFont.systemFont(ofSize: 17)
            customTextField.placeholder = "Engine capacity"
        case .phoneNumber:
            nameCellLabel.text = "+375 "
            customTextField.placeholder = "Phone number"
        case .cost:
            nameCellLabel.text = "Cost"
            customTextField.placeholder = "USD"
        case .mileage:
            nameCellLabel.text = "Mileage"
            nameCellLabel.font = UIFont.systemFont(ofSize: 17)
            customTextField.placeholder = "km"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let target = targetTextField,
              let text = customTextField.text,
              let textInt = Int(text) else { return false }
        switch target {
        case .year:
            realmServise.addAdsParams(year: textInt)
            return true
        case .capacity:
            realmServise.addAdsParams(capacity: textInt)
            return true
        case .cost:
            realmServise.addAdsParams(cost: textInt)
            return true
        case .phoneNumber:
            realmServise.addAdsParams(phone: textInt)
            return true
        case .mileage:
            realmServise.addAdsParams(mileage: textInt)
            return true
        }
    }
    
//MARK: Consteint
    private func addConstreint() {
        nameCellLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.top.equalToSuperview().inset(16)
            $0.width.equalTo(contentView.frame.width * 0.35)
        }
        
        customTextField.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(nameCellLabel.snp.trailing)
            $0.width.equalTo(contentView.frame.width * 0.65)
        }
    }
    
    private func addElements() {
        contentView.addSubview(nameCellLabel)
        contentView.addSubview(customTextField)
    }
}
