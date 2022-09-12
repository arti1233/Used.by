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
                self.saveAdsButton.isEnabled = self.userData.isUserSingIn
            default:
                break
            }
        }
        
        if userData.userID != "" {
            firebase.chekSaveAdsOrNot(userId: userData.userID, adsId: adsInfo.id, complition: { [weak self] result in
                guard let self = self else { return }
                self.changeSaveButton(isAdsSave: result)
            })
        } else {
            saveAdsButton.isEnabled = false
        }
        if isUserAds {
            callButton.isEnabled = false
            saveAdsButton.isEnabled = false
        }
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
        showAlertController()
    }
    
    @objc private func saveAdsPressed(sender: UIButton) {
        guard let adsInfo = adsInfo else { return }
        firebase.addSaveUserAds(userId: userData.userID, adsId: adsInfo.id) { [weak self] result in
            guard let self = self else { return }
            self.changeSaveButton(isAdsSave: result)
        }
    }
    
    
    
//MARK: Metods
    
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

            let alertController = UIAlertController(title: "Phone number", message: "", preferredStyle: .actionSheet)
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
            $0.width.equalTo(view.frame.width * 0.7)
            $0.height.equalTo(50)
        }
        
        saveAdsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(view.frame.width * 0.2)
            $0.height.equalTo(50)
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
