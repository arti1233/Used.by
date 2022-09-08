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
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseDatabaseSwift
import FirebaseDatabase
import FirebaseStorage

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
    private var notificationToken: NotificationToken?
    private var realmServise: RealmServiceProtocol!
    private var userData = UserRealmModel()
    private var firebase: FireBaseProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        realmServise = RealmService()
        firebase = FireBaseService()
        userData = realmServise.getUserData()
        guard let adsInfo = adsInfo else { return }
        firebase.chekSaveAdsOrNot(userId: userData.userID, adsId: adsInfo.id, complition: { [weak self] result in
            guard let self = self else { return }
            self.changeSaveButton(isAdsSave: result)
        })
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
        
    }
    
    @objc private func saveAdsPressed(sender: UIButton) {
        guard let adsInfo = adsInfo else { return }
        firebase.addSaveUserAds(userId: userData.userID, adsId: adsInfo.id) { [weak self] result in
            guard let self = self else { return }
            self.changeSaveButton(isAdsSave: result)
        }
    }
    
//MARK: Metods
    
    func changeSaveButton(isAdsSave: Bool) {
        if isAdsSave {
            saveAdsButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveAdsButton.tintColor = .yellow
        } else {
            saveAdsButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            saveAdsButton.tintColor = .white
        }
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
            
        cellForAds.updateConstraints()
        cellForSpec.updateConstraints()
        cellForAds.selectionStyle = .none
        cellForSpec.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cellForAds.changeSmallDescription(adsInfo: info)
            cellForAds.changeTitleCell(adsInfo: info)
            cellForAds.backgroundColor = .clear
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
