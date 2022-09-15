//
//  ChooseCostViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 24.08.22.
//

import Foundation
import UIKit
import SnapKit


class  ChooseCostVC: BaseViewController, UITextFieldDelegate {
    static let key = "ChooseCostViewController"
    
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
    
    private lazy var minCostTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = " from"
        textlabel.keyboardType = .numberPad
        textlabel.delegate = self
        return textlabel
    }()
    
    private lazy var maxCostTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = " to"
        textlabel.keyboardType = .numberPad
        textlabel.delegate = self
        return textlabel
    }()
    
    private var realmServise: RealmServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        addElements()
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreit()
    }

//MARK: Actions
    @objc fileprivate func closeVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func acceptWithChoise(sender: UIButton) {
        guard let costMin = minCostTextField.text,
              let costMax = maxCostTextField.text,
              !costMin.isEmpty,
              !costMax.isEmpty,
              let costMinInt = Int(costMin),
              let costMaxInt = Int(costMax) else { return }
        
        realmServise.addObjectInSearchSetting(costMin: costMinInt)
        realmServise.addObjectInSearchSetting(costMax: costMaxInt)
        dismiss(animated: true)
        
    }
//MARK: Metods 
    func changeTitleName(name: String) {
        titleName.text = name
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)),
              let currentText = textField.text,
              let stringRange = Range(range, in: currentText)  else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 7
    }

//MARK: Metods for constreint
    private func addConstreit() {

        titleName.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        minCostTextField.snp.makeConstraints {
            $0.top.equalTo(titleName.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        maxCostTextField.snp.makeConstraints {
            $0.top.equalTo(minCostTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        acceptButton.snp.makeConstraints {
            $0.top.equalTo(maxCostTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(40)
            $0.centerY.equalTo(titleName.snp.centerY)
            closeButton.layer.cornerRadius = 40 / 2
        }
    }
    
    private func addElements() {
        view.addSubview(titleName)
        view.addSubview(minCostTextField)
        view.addSubview(maxCostTextField)
        view.addSubview(acceptButton)
        view.addSubview(closeButton)
    }
}
