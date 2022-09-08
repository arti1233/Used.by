//
//  TextViewVC.swift
//  Used.by
//
//  Created by Artsiom Korenko on 2.09.22.
//

import Foundation
import UIKit
import SnapKit

class TextViewVC: BaseViewController {
    
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .left
        titleName.text = "Specification"
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
    
    private lazy var descriptionTextView: UITextView = {
        var view = UITextView()
        view.tintColor = .myCustomPurple
        view.font = UIFont.systemFont(ofSize: 21)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var realmServise: RealmServiceProtocol!
    private var adsParams = AdsConfigure()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        adsParams = realmServise.getAdsParams()
        addElements()
        descriptionTextView.text = adsParams.descriptionCar
        registerForKeyboardNotification()
        
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint(keyboardHeight: 32)
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
//MARK: Actions
    @objc fileprivate func closeVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc fileprivate func acceptWithChoise(_ sender: UIButton) {
        if let text = descriptionTextView.text, !text.isEmpty {
            realmServise.addAdsParams(descriptionCar: text)
            dismiss(animated: true)
        }
    }
    
// MARK: Metods
    func changeTitleName(name: String) {
        titleName.text = name
    }
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notifiation: NSNotification) {
        if let keyboardSize = (notifiation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            addConstreint(keyboardHeight: Int(keyboardSize.height))
        }
    }
    
    @objc private func keyboardWillHide(_ notifiation: NSNotification) {
        addConstreint(keyboardHeight: 32)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//MARK: Metods for constreint
    private func addConstreint(keyboardHeight: Int) {
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
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(titleName.snp.bottom).offset(16)
            $0.bottom.equalTo(acceptButton.snp.top).offset(-16)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
        
        acceptButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.snp.bottom).inset(keyboardHeight)
            $0.height.equalTo(40)
        }
    }
    
    private func addElements() {
        view.addSubview(titleName)
        view.addSubview(closeButton)
        view.addSubview(descriptionTextView)
        view.addSubview(acceptButton)
    }
    
}
