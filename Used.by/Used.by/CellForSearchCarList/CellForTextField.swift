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
enum TargetStateCell: CaseIterable {
    case cost
    case phoneNumber
    case mileage
}

class CellForTextField: UITableViewCell, UITextFieldDelegate {

    static let key = "CellForTextField"
    private var realmServise: RealmServiceProtocol!
    var targetTextField: TargetStateCell!
    private var adsConfigure = AdsConfigure()
    private var limitSymbols = 0
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .myColorForCell
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var customTextField: CustomTextField = {
        var field = CustomTextField()
        field.font = UIFont.systemFont(ofSize: 21)
        field.keyboardType = .default
        field.backgroundColor = .myColorForCell
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
        addConstreint()
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
        
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)),
              let currentText = textField.text,
              let stringRange = Range(range, in: currentText)  else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= limitSymbols
    }
    
//MARK: Metods
    
    func changeTextField(text: String) {
        customTextField.text = text
    }
    
    private func changeTargetTextField(target: TargetStateCell) {
        switch target {
        case .phoneNumber:
            nameCellLabel.text = "+375"
            customTextField.placeholder = "Phone number"
            limitSymbols = 9
        case .cost:
            nameCellLabel.text = "USD"
            customTextField.placeholder = "Cost"
            limitSymbols = 7
        case .mileage:
            nameCellLabel.text = "km"
            nameCellLabel.font = UIFont.systemFont(ofSize: 21)
            customTextField.placeholder = "Mileage"
            limitSymbols = 7
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let target = targetTextField,
              let text = customTextField.text,
              let textInt = Int(text) else { return false }
        switch target {
        case .cost:
            realmServise.addAdsParams(cost: textInt)
        case .phoneNumber:
            realmServise.addAdsParams(phone: textInt)
        case .mileage:
            realmServise.addAdsParams(mileage: textInt)
        }
        return true
    }
    

    
//MARK: Consteint
    
    private func addConstreint() {
        mainView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        nameCellLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.top.equalToSuperview().inset(16)
            $0.width.equalTo(contentView.frame.width * 0.2)
        }
        
        customTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.leading.equalTo(nameCellLabel.snp.trailing).offset(16)
        }
    }
    
    private func addElements() {
        contentView.addSubview(mainView)
        mainView.addSubview(nameCellLabel)
        mainView.addSubview(customTextField)
    }
}
