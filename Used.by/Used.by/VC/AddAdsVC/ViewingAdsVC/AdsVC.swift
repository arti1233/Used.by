//
//  AdsVC.swift
//  Used.by
//
//  Created by Artsiom Korenko on 31.08.22.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class AdsVC: BaseViewController {
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdsCell.self, forCellReuseIdentifier: AdsCell.key)
        tableView.register(CellForSpecification.self, forCellReuseIdentifier: CellForSpecification.key)
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var callButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Сall the seller", for: .normal)
        button.addTarget(self, action: #selector(callButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveAdsButton: CustomButton = {
        var button = CustomButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(saveAdsPressed), for: .touchUpInside)
        return button
    }()

    var adsInfo: AdsInfo?
    private var realmServise: RealmServiceProtocol!
    private var userData = UserRealmModel()
    private var firebase: FireBaseProtocol!
    private var notificationToken: NotificationToken?
    
    var isUserAds = false
    private var arrayImage: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        offLargeTitle()
        addElements()
        realmServise = RealmService()
        firebase = FireBaseService()
        userData = realmServise.getUserData()
        guard let adsInfo = adsInfo else { return }
        
        notificationToken = userData.observe{ [weak self] change in
            guard let self = self else { return }
            switch change {
            case .change(_, _):
                self.userData = self.realmServise.getUserData()
            default:
                break
            }
        }
        
        if userData.userID != "" {
            firebase.chekSaveAdsOrNot(userId: userData.userID, adsId: adsInfo.id, complition: { [weak self] result in
                guard let self = self else { return }
                self.changeSaveButton(isAdsSave: result)
            })
        }
        
        changeCallButton(isUserAds: isUserAds)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint()
        if let info = adsInfo {
            title = "\(info.carBrend) \(info.carModel)"
        }
    }
    
    deinit {
        guard let token = notificationToken else { return }
        token.invalidate()
    }
    
//MARK: Actions
    @objc private func callButtonPressed(sender: UIButton) {
        if isUserAds {
            allertForDeletButton()
        } else {
            showAlertController()
        }
    }
    
    @objc private func saveAdsPressed(sender: UIButton) {
        if !isUserAds {
            if userData.isUserSingIn {
                guard let adsInfo = adsInfo else { return }
                firebase.addSaveUserAds(userId: userData.userID, adsId: adsInfo.id) { [weak self] result in
                    guard let self = self else { return }
                    self.changeSaveButton(isAdsSave: result)
                }
            } else {
                alertForSaveButton()
            }
        }
    }
    
    
    
//MARK: Metods
    private func changeCallButton(isUserAds: Bool) {
        callButton.setTitle(isUserAds ? "Delete your ads" : "Сall the seller", for: .normal)
        callButton.backgroundColor = isUserAds ? .logInColor : .myCustomPurple
        saveAdsButton.isHidden = isUserAds
        if isUserAds {
            callButton.snp.makeConstraints { [weak self] in
                guard let self = self else { return }
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(50)
            }
            saveAdsButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(0)
                $0.bottom.equalToSuperview().inset(0)
                $0.height.width.equalTo(0)
            }
        }
    }
    
    private func changeSaveButton(isAdsSave: Bool) {
        saveAdsButton.setImage(UIImage(systemName: isAdsSave ? "bookmark.fill" : "bookmark"), for: .normal)
        saveAdsButton.tintColor = isAdsSave ? .yellow : .white
    }
    
    private func presentLookPhotoVC(arrayImage: [UIImage]) {
        let vc = LookPhotoVC()
        vc.arrayImages = arrayImage
        guard let info = adsInfo else { return }
        vc.titleName = "\(info.carBrend) \(info.carModel)"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
// MARK: AlertController
    private func showAlertController() {
        guard let adsInfo = adsInfo else { return }
        
        let alertController = UIAlertController(title: nil, message: "Seller's phone number", preferredStyle: .actionSheet)
        let phoneNumber = UIAlertAction(title: "+375 29 \(adsInfo.phoneNumber)", style: .default) { _ in
            if let phoneCallURL = URL(string: "tel://+375\(adsInfo.phoneNumber)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
        let closeButton = UIAlertAction(title: "Close", style: .cancel)
        
        alertController.addAction(closeButton)
        alertController.addAction(phoneNumber)
        present(alertController, animated: true)
    }
    
    private func alertForSaveButton() {
        let alertController = UIAlertController(title: "Attention", message: "In order to save the ad, log in to your account", preferredStyle: .alert)
        let phoneNumber = UIAlertAction(title: "Log in", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            let vc = LoginFormViewController()
            self.present(vc, animated: true)
        }
        let closeButton = UIAlertAction(title: "Close", style: .destructive)
        
        alertController.addAction(closeButton)
        alertController.addAction(phoneNumber)
        present(alertController, animated: true)
    }
    
    private func allertForDeletButton() {
        let alertController = UIAlertController(title: "Attention", message: "Do you want to delete your ad?", preferredStyle: .alert)
        let deletButton = UIAlertAction(title: "Delet", style: .destructive) { [weak self] _ in
            guard let self = self, let adsInfo = self.adsInfo else { return }
            self.firebase.deletUserAds(userId: self.userData.userID, adsId: adsInfo.id)
            self.navigationController?.popViewController(animated: true)
        }
        let closeButton = UIAlertAction(title: "Close", style: .cancel)
        
        alertController.addAction(closeButton)
        alertController.addAction(deletButton)
        present(alertController, animated: true)
    }
    
    
// MARK: Metods for constreint
    
    private func addConstreint() {
        
        tableView.snp.makeConstraints {
            $0.bottom.equalTo(callButton.snp.top).offset(8)
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets)
        }
        
        callButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(saveAdsButton.snp.leading).offset(-8)
            $0.height.equalTo(50)
        }
        
        saveAdsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.width.equalTo(50)
        }
        
    }
    
    private func addElements() {
        view.addSubview(tableView)
        view.addSubview(callButton)
        view.addSubview(saveAdsButton)
    }
}

extension AdsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForAds = tableView.dequeueReusableCell(withIdentifier: AdsCell.key) as? AdsCell,
              let cellForSpec = tableView.dequeueReusableCell(withIdentifier: CellForSpecification.key) as? CellForSpecification,
              let info = adsInfo else { return UITableViewCell() }
            
        cellForSpec.updateConstraints()
        cellForAds.selectionStyle = .none
        cellForSpec.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cellForAds.changeSmallDescription(adsInfo: info)
            cellForAds.backgroundColor = .clear
            cellForAds.isSmallCell = false
            cellForAds.isTransitionOnLookPhoto = true
            cellForAds.complition = { [weak self] result in
                guard let self = self else { return }
                self.arrayImage = result
                if !self.arrayImage.isEmpty {
                    self.presentLookPhotoVC(arrayImage: self.arrayImage)
                }
            }
            cellForAds.updateConstraints()
            return cellForAds
        case 1:
            cellForSpec.changeDiscription(adsInfo: info.responseDescription)
            cellForSpec.backgroundColor = .clear
            return cellForSpec
        default:
            return UITableViewCell()
        }
    }
}
