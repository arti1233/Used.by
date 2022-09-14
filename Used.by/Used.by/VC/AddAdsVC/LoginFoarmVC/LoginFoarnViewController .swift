//
//  LoginFoarnViewController .swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit
import GoogleSignInSwift
import GoogleSignIn
import RealmSwift

final class LoginFormViewController: UIViewController {
   
    private var userDataResults: Results<UserRealmModel>!
    private var userData = UserRealmModel()
    private var realmServise: RealmServiceProtocol!
    private var fireBase: FireBaseProtocol!
    private var signInConfig: GIDConfiguration!
    
    private lazy var googleButton: GIDSignInButton = {
        var button = GIDSignInButton()
        button.colorScheme = .light
        button.style = .wide
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    private lazy var viewForTitle: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
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
        textlabel.placeholder = "Enter email adress"
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        spacerView.backgroundColor = .clear
        textlabel.leftViewMode = .always
        textlabel.leftView = spacerView
        return textlabel
    }()
    // TextField пароля для входа
    private lazy var passwordForEntryTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "Password"
        textlabel.textContentType = .password
        textlabel.isSecureTextEntry = true
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        spacerView.backgroundColor = .clear
        textlabel.leftViewMode = .always
        textlabel.leftView = spacerView
        return textlabel
    }()
    
    private lazy var loginButton: CustomButton = {
        var loginButton = CustomButton()
        loginButton.setTitle("Log in", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
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
        textlabel.placeholder = "Enter your name"
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        spacerView.backgroundColor = .clear
        textlabel.leftViewMode = .always
        textlabel.leftView = spacerView
        return textlabel
    }()
    // TextField почты для регистрации
    private lazy var emailForRegisterTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "Enter email adress"
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        spacerView.backgroundColor = .clear
        textlabel.leftViewMode = .always
        textlabel.leftView = spacerView
        return textlabel
    }()
    // TextField пароля для регистрации
    private lazy var passwordForRegisterTextField: CustomTextField = {
        var textlabel = CustomTextField()
        textlabel.placeholder = "Password"
        textlabel.textContentType = .password
        textlabel.isSecureTextEntry = true
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        spacerView.backgroundColor = .clear
        textlabel.leftViewMode = .always
        textlabel.leftView = spacerView
        return textlabel
    }()
    
    private lazy var registrationButton: CustomButton = {
        var registrationButton = CustomButton()
        registrationButton.setTitle("Registration", for: .normal)
        registrationButton.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
        return registrationButton
    }()
    
// MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        title = "USED.BY"
        addElementsToSuperview()
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else { return }
        signInConfig = GIDConfiguration(clientID: clientId)
        changeViewForIndexSegment(index: segmentController.selectedSegmentIndex)
        view.backgroundColor = UIColor.tabBarColor
        userDataResults = realmServise.getUsersRealmModel()
        userData = realmServise.getUserData()
        addKeyBoardObserver()
        fireBase = FireBaseService()
        loginNameForRegisterTextField.delegate = self
        emailForRegisterTextField.delegate = self
        passwordForRegisterTextField.delegate = self
        emailForEntryTextField.delegate = self
        passwordForEntryTextField.delegate = self
    }
    
    deinit {
        removeKeyboardObserver()
    }
    
    
// MARK: UpdateViewConstraints
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addMainElements()
        addViewEnterUser(value: 0)
        addViewRegisterUser(value: 0)
    }
    
// MARK: Actions
    
    // Actions for segment controller
    @objc fileprivate func changeView(_ sender: UISegmentedControl) {
        changeViewForIndexSegment(index: sender.selectedSegmentIndex)
    }
    
    // Actions for loginButton
    @objc fileprivate func loginButtonPressed(sender: UIButton) {
        guard let email = emailForEntryTextField.text,
              let password = passwordForEntryTextField.text,
              !email.isEmpty,
              !password.isEmpty else { return }
        fireBase.signInFireBase(email: email, password: password) { [weak self] result, userId in
            guard let self = self else { return }
            if result {
                self.realmServise.addUserData(ID: userId)
                self.realmServise.addUserData(isUserSignIn: true)
                self.dismiss(animated: true)
            } else {
                self.showAlertController(textError: "Invalid username or password")
            }
        }
    }
    
// Actions for registerButton
    @objc fileprivate func registrationButtonPressed(sender: UIButton) {
        guard let name = loginNameForRegisterTextField.text,
              let email = emailForRegisterTextField.text,
              let password = passwordForRegisterTextField.text,
              !name.isEmpty,
              !email.isEmpty,
              !password.isEmpty else { self.showAlertController(textError: "Fill in all the fields")
                return }
        guard password.count >= 6 else { self.showAlertController(textError: "the password must contain at least 6 characters")
            return }
        fireBase.createNewUser(email: email, password: password, name: name) { [weak self] result, userId in
            guard let self = self else { return }
            if result {
                self.realmServise.addUserData(ID: userId)
                self.realmServise.addUserData(isUserSignIn: true)
                self.dismiss(animated: true)
            } else {
                self.showAlertController(textError: "Wrong email adress")
            }
        }
    }
    
// Google SigIn button
    @objc fileprivate func signIn() {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [weak self] user, error in
            
            guard let self = self, error == nil, let user = user, let userProfile = user.profile, let userId = user.userID else { return }
            self.fireBase.addNewUserForGoogle(name: userProfile.name, email: userProfile.email, userIdGoogle: userId)
            self.realmServise.addUserData(ID: userId)
            self.realmServise.addUserData(isUserSignIn: true)
            self.dismiss(animated: true)
        }
    }
    
// MARK: AlertController
    private func showAlertController(textError: String) {
        let alertController = UIAlertController(title: "Error", message: textError, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "Close", style: .cancel)
        
        alertController.addAction(closeButton)
        present(alertController, animated: true)
    }
    
// MARK: Metods
    
    private func addKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self)
    }
            
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        view.frame.origin.y = 0
        guard let userInfo = notification.userInfo else { return }
        
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        
        guard let keyboard = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let height = view.frame.maxY - viewForRegisterUser.frame.minY - passwordForRegisterTextField.frame.maxY
        let value = keyboard.height - height
        
        if value > 0 {
            view.frame.origin.y = -value - 32
        }
        
        
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        
        guard let userInfo = notification.userInfo else { return }
        
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        
        guard let keyboard = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
   
        view.frame.origin.y = 0


    }
    
    // Метод измения с входа на регистрацию
    private func changeViewForIndexSegment(index: Int) {
        viewForEntryUser.isHidden = index == 1
        viewForRegisterUser.isHidden = index == 0
    }

    // Добавление элементов которые не зависят от действия (вход или регистрация)
    private func addMainElements() {
        
        viewForTitle.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(128)
        }
        
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
    private func addViewEnterUser(value: Int) {
        viewForEntryUser.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(128 - value)
        }
        
        emailForEntryTextField.snp.makeConstraints {
            $0.top.equalTo(viewForEntryUser.snp.top).inset(16)
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
        
        googleButton.snp.makeConstraints {
            $0.trailing.leading.equalTo(viewForEntryUser).inset(16)
            $0.height.equalTo(70)
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
        }
    }
    
    // Добавление вью с регистрацией
    private func addViewRegisterUser(value: Int) {
        viewForRegisterUser.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(128 - value)
        }
        
        loginNameForRegisterTextField.snp.makeConstraints {
            $0.top.equalTo(viewForRegisterUser.snp.top).inset(16)
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
        view.addSubview(viewForEntryUser)
        viewForEntryUser.addSubview(emailForEntryTextField)
        viewForEntryUser.addSubview(passwordForEntryTextField)
        viewForEntryUser.addSubview(loginButton)
        viewForEntryUser.addSubview(googleButton)
        view.addSubview(viewForRegisterUser)
        viewForRegisterUser.addSubview(loginNameForRegisterTextField)
        viewForRegisterUser.addSubview(emailForRegisterTextField)
        viewForRegisterUser.addSubview(passwordForRegisterTextField)
        viewForRegisterUser.addSubview(registrationButton)
        view.addSubview(viewForTitle)
        viewForTitle.addSubview(titleName)
        viewForTitle.addSubview(segmentController)
    }
}


extension LoginFormViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
        case emailForEntryTextField:
            passwordForEntryTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        switch textField {
        case loginNameForRegisterTextField:
            emailForRegisterTextField.becomeFirstResponder()
            
        case emailForRegisterTextField:
            passwordForRegisterTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }

        return false

    }
    
    
}
    
