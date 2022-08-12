//
//  LoginFoarnViewController .swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit

final class LoginFormViewController: UIViewController {
    // Назвпние приложения в title
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .center
        titleName.text = "USED.BY"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
    
    // SegmentController для переключения между регистрацией и входом
    private lazy var segmentController: UISegmentedControl = {
        var segmentController = UISegmentedControl(items: ["Log in", "Registration"])
        segmentController.selectedSegmentIndex = 0
        segmentController.selectedSegmentTintColor = UIColor.myCustomPurple
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        segmentController.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
        return segmentController
    }()
    
    //MARK: View для входа
    private lazy var viewForEntryUser: UIView = {
        var viewEnterUser = UIView()
        viewEnterUser.backgroundColor = UIColor.mainBackgroundColor
        return viewEnterUser
    }()
    // TextField почты для входа
    private lazy var emailForEntryTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "  Enter email adress"
        return textlabel
    }()
    // TextField пароля для входа
    private lazy var passwordForEntryTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "  Password"
        return textlabel
    }()
    
    private lazy var loginButton: CustomButton = {
        var loginButton = CustomButton()
        loginButton.setTitle("Log in", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.`self`()
        return loginButton
    }()
    
    //MARK: View для регистрации
    private lazy var viewForRegisterUser: UIView = {
        var viewRegisterUser = UIView()
        viewRegisterUser.backgroundColor = UIColor.mainBackgroundColor
        return viewRegisterUser
    }()
    // TextField имени пользователя(ник) для регистрации
    private lazy var loginNameForRegisterTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "  Enter your name"
        return textlabel
    }()
    // TextField почты для регистрации
    private lazy var emailForRegisterTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "  Enter email adress"
        return textlabel
    }()
    // TextField пароля для регистрации
    private lazy var passwordForRegisterTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "  Password"
        return textlabel
    }()
    
    private lazy var registrationButton: CustomButton = {
        var registrationButton = CustomButton()
        registrationButton.setTitle("Registration", for: .normal)
        registrationButton.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
        registrationButton.`self`()
        return registrationButton
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addElementsToSuperview()
        
        changeViewForIndexSegment(index: segmentController.selectedSegmentIndex)
        view.backgroundColor = UIColor.colorForHeaderLoginFoarm
    }
    
    // MARK: UpdateViewConstraints
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addMainElements()
        addViewEnterUser()
        addViewRegisterUser()
    }
    
    
    
    // MARK: Actions
    
    // Actions for segment controller
    @objc fileprivate func changeView(_ sender: UISegmentedControl) {
        changeViewForIndexSegment(index: sender.selectedSegmentIndex)
    }
    
    // Actions for loginButton
    @objc fileprivate func loginButtonPressed(sender: UIButton) {
        
    }
    
    // Actions for registerButton
    
    @objc fileprivate func registrationButtonPressed(sender: UIButton) {
        
    }
    
    
    
    
    // MARK: Metods
    // Метод измения с входа на регистрацию
    private func changeViewForIndexSegment(index: Int) {
        viewForEntryUser.isHidden = index == 1
        viewForRegisterUser.isHidden = index == 0
    }
    
    
    // Добавление элементов которые не зависят от действия (вход или регистрация)
    private func addMainElements() {
        titleName.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        segmentController.snp.makeConstraints {
            $0.top.equalTo(titleName.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
    }
    
    // Добавление вью с авторизацией
    private func addViewEnterUser() {
        viewForEntryUser.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(segmentController.snp.bottom).offset(16)
        }
        
        emailForEntryTextField.snp.makeConstraints {
            $0.top.equalTo(viewForEntryUser.snp.top).inset(48)
            $0.leading.trailing.equalTo(viewForEntryUser).inset(16)
            $0.height.equalTo(70)
        }
        
        passwordForEntryTextField.snp.makeConstraints {
            $0.top.equalTo(emailForEntryTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(viewForEntryUser).inset(16)
            $0.height.equalTo(70)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordForEntryTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(viewForEntryUser).inset(16)
            $0.height.equalTo(70)
        }
    }
    
    // Добавление вью с регистрацией
    private func addViewRegisterUser() {
        viewForRegisterUser.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(segmentController.snp.bottom).offset(16)
        }
        
        loginNameForRegisterTextField.snp.makeConstraints {
            $0.top.equalTo(viewForRegisterUser.snp.top).inset(48)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }
        
        emailForRegisterTextField.snp.makeConstraints {
            $0.top.equalTo(loginNameForRegisterTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }
        
        passwordForRegisterTextField.snp.makeConstraints {
            $0.top.equalTo(emailForRegisterTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }
        
        registrationButton.snp.makeConstraints {
            $0.top.equalTo(passwordForRegisterTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }
    }
    
    private func addElementsToSuperview() {
        view.addSubview(titleName)
        view.addSubview(segmentController)
        view.addSubview(viewForEntryUser)
        viewForEntryUser.addSubview(emailForEntryTextField)
        viewForEntryUser.addSubview(passwordForEntryTextField)
        viewForEntryUser.addSubview(loginButton)
        view.addSubview(viewForRegisterUser)
        viewForRegisterUser.addSubview(loginNameForRegisterTextField)
        viewForRegisterUser.addSubview(emailForRegisterTextField)
        viewForRegisterUser.addSubview(passwordForRegisterTextField)
        viewForRegisterUser.addSubview(registrationButton)
    }
}
