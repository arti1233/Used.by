//
//  LoginFoarnViewController .swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit

class LoginFoarnViewController: UIViewController {
    // Назвпние приложения в title
    private var titleName: UILabel = {
       var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .center
        titleName.text = "USED.BY"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
    
    // SegmentController для переключения между регистрацией и входом
    private var segmentController: UISegmentedControl = {
        var segmentController = UISegmentedControl(items: ["Log in", "Registration"])
        segmentController.selectedSegmentIndex = 0
        segmentController.selectedSegmentTintColor = UIColor.myCustomPurple
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        segmentController.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
        return segmentController
    }()
    
//MARK: View для входа
    private var viewForEntryUser: UIView = {
        var viewEnterUser = UIView()
        viewEnterUser.backgroundColor = UIColor.mainBackgroundColor
        return viewEnterUser
    }()
    // TextField почты для входа
    private var emailForEntryTextField: UITextField = {
        var textlabel = UITextField().mainTextFied
        textlabel.placeholder = "  Enter email adress"
        return textlabel
    }()
    // TextField пароля для входа
    private var passwordForEntryTextField: UITextField = {
        var textlabel = UITextField().mainTextFied
        textlabel.placeholder = "  Password"
        return textlabel
    }()
    
    private var loginButton: UIButton = {
        var loginButton = UIButton().mainButton
        loginButton.setTitle("Log in", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return loginButton
    }()
    
    
    
//MARK: View для регистрации
    private var viewForRegisterUser: UIView = {
        var viewRegisterUser = UIView()
        viewRegisterUser.backgroundColor = UIColor.mainBackgroundColor
        return viewRegisterUser
    }()
    // TextField имени пользователя(ник) для регистрации
    private var loginNameForRegisterTextField: UITextField = {
        var textlabel = UITextField().mainTextFied
        textlabel.placeholder = "  Enter your name"
        return textlabel
    }()
    // TextField почты для регистрации
    private var emailForRegisterTextField: UITextField = {
        var textlabel = UITextField().mainTextFied
        textlabel.placeholder = "  Enter email adress"
        return textlabel
    }()
    // TextField пароля для регистрации
    private var passwordForRegisterTextField: UITextField = {
        var textlabel = UITextField().mainTextFied
        textlabel.placeholder = "  Password"
        return textlabel
    }()
    
    private var registrationButton: UIButton = {
        var registrationButton = UIButton().mainButton
        registrationButton.setTitle("Registration", for: .normal)
        registrationButton.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
        return registrationButton
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMainElements()
        addViewEnterUser()
        addViewRegisterUser()
        changeViewForIndexSegment(index: segmentController.selectedSegmentIndex)
        
        
        
        
        view.backgroundColor = UIColor.colorForHeaderLoginFoarm
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
        switch index {
        case 0:
            viewForEntryUser.isHidden = false
            viewForRegisterUser.isHidden = true
        case 1:
            viewForEntryUser.isHidden = true
            viewForRegisterUser.isHidden = false
        default:
            break
        }
    }
    
    
    // Добавление элементов которые не зависят от действия (вход или регистрация)
    private func addMainElements() {
        view.addSubview(titleName)
        titleName.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        view.addSubview(segmentController)
        segmentController.snp.makeConstraints {
            $0.top.equalTo(titleName.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

    }
    
    // Добавление вью с авторизацией
    private func addViewEnterUser() {
        view.addSubview(viewForEntryUser)
        viewForEntryUser.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(segmentController.snp.bottom).offset(16)
        }
        
        viewForEntryUser.addSubview(emailForEntryTextField)
        emailForEntryTextField.snp.makeConstraints {
            $0.top.equalTo(viewForEntryUser.snp.top).inset(48)
            $0.leading.trailing.equalTo(viewForEntryUser).inset(16)
            $0.height.equalTo(70)
        }
        
        viewForEntryUser.addSubview(passwordForEntryTextField)
        passwordForEntryTextField.snp.makeConstraints {
            $0.top.equalTo(emailForEntryTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(viewForEntryUser).inset(16)
            $0.height.equalTo(70)
        }
        
        viewForEntryUser.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordForEntryTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(viewForEntryUser).inset(16)
            $0.height.equalTo(70)
        }
    }
    
    // Добавление вью с регистрацией
    private func addViewRegisterUser() {
        view.addSubview(viewForRegisterUser)
        viewForRegisterUser.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(segmentController.snp.bottom).offset(16)
        }
        
        viewForRegisterUser.addSubview(loginNameForRegisterTextField)
        loginNameForRegisterTextField.snp.makeConstraints {
            $0.top.equalTo(viewForRegisterUser.snp.top).inset(48)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }
        
        viewForRegisterUser.addSubview(emailForRegisterTextField)
        emailForRegisterTextField.snp.makeConstraints {
            $0.top.equalTo(loginNameForRegisterTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }
        
        viewForRegisterUser.addSubview(passwordForRegisterTextField)
        passwordForRegisterTextField.snp.makeConstraints {
            $0.top.equalTo(emailForRegisterTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }
        
        viewForRegisterUser.addSubview(registrationButton)
        registrationButton.snp.makeConstraints {
            $0.top.equalTo(passwordForRegisterTextField.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(viewForRegisterUser).inset(16)
            $0.height.equalTo(70)
        }

    }
    

}
