//
//  AddAdsVC.swift
//  Used.by
//
//  Created by Artsiom Korenko on 26.08.22.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class AddAdsVC: BaseViewController {
    
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .left
        titleName.text = "Create your ads"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()
    
    private lazy var createAdsButton: UIButton = {
        var button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor.myCustomPurple, for: .normal)
        button.addTarget(self, action: #selector(createAdsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellForTextField.self, forCellReuseIdentifier: CellForTextField.key)
        tableView.register(CellForRequestView.self, forCellReuseIdentifier: CellForRequestView.key)
        tableView.register(CellForDescription.self, forCellReuseIdentifier: CellForDescription.key)
        tableView.register(CellForAdsPhoto.self, forCellReuseIdentifier: CellForAdsPhoto.key)
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var userData = UserRealmModel()
    private var fireBase: FireBaseProtocol!
    private var realmServise: RealmServiceProtocol!
    private var alamofireProvider: RestAPIProviderProtocol!
    private var notificationToken: NotificationToken?
    private var adsResults: Results<AdsConfigure>!
    private let section = CreateSectionForCreateAds.allCases
    private var carBrendModel: [CarBrend] = []
    private var adsConfigure = AdsConfigure()
    private var catalogImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        realmServise = RealmService()
        realmServise.resetAdsParams()
        userData = realmServise.getUserData()
        alamofireProvider = AlamofireProvider()
        adsConfigure = realmServise.getAdsParams()
        adsResults = realmServise.getAdsConfigureList()
        fireBase = FireBaseService()
        registerForKeyboardNotification()
        getCarbrend()
    
        guard let items = adsResults.first else { return }
        notificationToken = items.observe{ [weak self] change in
            guard let self = self else { return }
            switch change {
            case .change(_, _):
                self.adsConfigure = self.realmServise.getAdsParams()
                self.tableView.reloadData()
            default:
                break
            }
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint()
        getCarbrend()
    }
    
    deinit {
        removeKeyboardNotification()
        guard let token = notificationToken else { return }
        token.invalidate()
    }
    
    
// MARK: Metods for constreint
    
    private func addConstreint() {
        titleName.snp.makeConstraints{
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(65)
        }
        
        createAdsButton.snp.makeConstraints {
            $0.centerY.equalTo(titleName.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

    }
    
    private func addElements() {
        view.addSubview(titleName)
        view.addSubview(tableView)
        view.addSubview(createAdsButton)
    }
    
//MARK: Actions
    
    @objc private func keyboardWillShow(_ notifiation: NSNotification) {
        if let keyboardSize = (notifiation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let edgeInset: UIEdgeInsets = .init(top: 0, left: 0, bottom: keyboardSize.height - view.safeAreaInsets.bottom, right: 0)
            tableView.contentInset = edgeInset
            tableView.scrollIndicatorInsets = edgeInset
        }
    }
    
    @objc private func keyboardWillHide(_ notifiation: NSNotification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    @objc private func createAdsButtonPressed(sender: UIButton) {
        guard adsConfigure.carBrendName != "",
              adsConfigure.carModelName != "",
              adsConfigure.year != 0,
              adsConfigure.typeEngine != 0,
              adsConfigure.gearbox != 0,
              adsConfigure.typeDrive != 0,
              adsConfigure.capacity != 0,
              adsConfigure.mileage != 0,
              adsConfigure.descriptionCar != "",
              adsConfigure.phoneNumber != 0,
              adsConfigure.cost != 0,
              adsConfigure.condition != 0,
              catalogImage.count >= 4,
              catalogImage.count <= 6 else {
                  showAlertController(text: "Check all text fields")
            return
        }
        fireBase.createNewAds(userId: userData.userID,
                              carBrend: adsConfigure.carBrendName,
                              carModel: adsConfigure.carModelName,
                              year:  adsConfigure.year,
                              typeEngine: adsConfigure.typeEngine,
                              gearBox: adsConfigure.gearbox,
                              typeDrive: adsConfigure.typeDrive,
                              capacity: adsConfigure.capacity,
                              mileage: adsConfigure.mileage,
                              cost: adsConfigure.cost,
                              description: adsConfigure.descriptionCar,
                              photo: catalogImage,
                              phoneNumber: adsConfigure.phoneNumber,
                              condition: adsConfigure.condition)
        dismiss(animated: true)
    }
    
// MARK: Metods
    
    private func presentPickerForAdsVC(isCapacity: Bool) {
        let vc = PickerForAddAdsVC()
        vc.isCapacityPicker = isCapacity
        vc.isCapacityPicker ? vc.changeTitleName(name: "Capacity engine") : vc.changeTitleName(name: "Year of prodaction")
        
        if let presentationConroller = vc.presentationController as? UISheetPresentationController {
            presentationConroller.detents = [.medium()]
        }
        
        present(vc, animated: true)
    }
    
    fileprivate func showAlertController(text: String) {
        let alertController = UIAlertController(title: "Please", message: text, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "Close", style: .cancel)
        
        alertController.addAction(closeButton)
        present(alertController, animated: true)
    }
    
    private func getCarbrend() {
        alamofireProvider.getCarBrendInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.carBrendModel = result
            case .failure:
                print("ERROR")
            }
        }
    }
    
    // image Picker
    
    func imagePickerForAllerController(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    // go to ChooseParamsVC
    
    func presentChooseParamsVC(target: ChooseParamsEnum) {
        let vc = ChooseParamsVC()
        vc.parametrs = target
        if let presentationConroller = vc.presentationController as? UISheetPresentationController {
            presentationConroller.detents = [.medium()]
        }
        present(vc, animated: true)
    }
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension AddAdsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        CreateSectionForCreateAds.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CreateSectionForCreateAds.allCases[section].cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForRequestView = tableView.dequeueReusableCell(withIdentifier: CellForRequestView.key) as? CellForRequestView,
              let cellForDescription = tableView.dequeueReusableCell(withIdentifier: CellForDescription.key) as? CellForDescription,
              let cellForPhoneNumber = tableView.dequeueReusableCell(withIdentifier: CellForTextField.key) as? CellForTextField,
              let cellForPhoto = tableView.dequeueReusableCell(withIdentifier: CellForAdsPhoto.key) as? CellForAdsPhoto
              else { return UITableViewCell() }
        
        let section = section[indexPath.section]
        cellForRequestView.updateConstraints()
        cellForPhoneNumber.updateConstraints()
        cellForDescription.updateConstraints()
        cellForPhoto.updateConstraints()
        
        cellForRequestView.backgroundColor = .clear
        cellForPhoneNumber.backgroundColor = .clear
        cellForDescription.backgroundColor = .clear
        cellForPhoto.backgroundColor = .clear
        
        cellForRequestView.selectionStyle = .none
        cellForPhoneNumber.selectionStyle = .none
        cellForDescription.selectionStyle = .none
        cellForPhoto.selectionStyle = .none
        
        switch section {
        case .carBrend:
            switch ModelCars.allCases[indexPath.row] {
            case .carBrend:
                cellForRequestView.changeFieldName(name: ModelCars.allCases[indexPath.row].title)
                cellForRequestView.changeResultLabel(name: adsConfigure.carBrendName)
                return cellForRequestView
            case .carModel:
                cellForRequestView.changeFieldName(name: ModelCars.allCases[indexPath.row].title)
                cellForRequestView.changeResultLabel(name: adsConfigure.carModelName)
                return cellForRequestView
            }
        case .parametrs:
            switch ParametrsForAds.allCases[indexPath.row] {
            case .year:
                cellForRequestView.changeFieldName(name: "Year of production")
                cellForRequestView.changeResultLabel(name: adsConfigure.year == 0 ? "" : String(adsConfigure.year))
                return cellForRequestView
            case .typeEngine:
                cellForRequestView.changeFieldName(name: ParametrsForAds.allCases[indexPath.row].title)
                var text = ""
                TypeEngime.allCases.forEach {
                    if TypeEngimeStruct(rawValue: adsConfigure.typeEngine).contains($0.options) {
                        text = "\($0.title)"
                    }
                }
                cellForRequestView.changeResultLabel(name: text)
                return cellForRequestView
            case .gearbox:
                cellForRequestView.changeFieldName(name: ParametrsForAds.allCases[indexPath.row].title)
                var text = ""
                GearBox.allCases.forEach {
                    if GearBoxStruct(rawValue: adsConfigure.gearbox).contains($0.options) {
                        text = "\($0.title)"
                    }
                }
                cellForRequestView.changeResultLabel(name: text)
                return cellForRequestView
            case .typeDrive:
                cellForRequestView.changeFieldName(name: ParametrsForAds.allCases[indexPath.row].title)
                var text = ""
                TypeOfDrive.allCases.forEach {
                    if TypeOfDriveStruct(rawValue: adsConfigure.typeDrive).contains($0.options) {
                        text = "\($0.title)"
                    }
                }
                cellForRequestView.changeResultLabel(name: text)
                return cellForRequestView
            case .capacityEngine:
                cellForRequestView.changeFieldName(name: "Capacity engine")
                cellForRequestView.changeResultLabel(name: adsConfigure.capacity == 0 ? "" : String(adsConfigure.capacity))
                return cellForRequestView
            case .mileage:
                cellForPhoneNumber.changeTextField(text: adsConfigure.mileage == 0 ? "" : String(adsConfigure.mileage))
                cellForPhoneNumber.targetTextField = TargetStateCell.mileage
                cellForPhoneNumber.prepareForReuse()
                return cellForPhoneNumber
            case .condition:
                cellForRequestView.changeFieldName(name: ParametrsForAds.allCases[indexPath.row].title)
                var text = ""
                ConditionsForAddAds.allCases.forEach {
                    if ConditionStruct(rawValue: adsConfigure.condition).contains($0.options) {
                        text = "\($0.title)"
                    }
                }
                cellForRequestView.changeResultLabel(name: text)
                return cellForRequestView
            }
        case .cost:
            cellForPhoneNumber.changeTextField(text: adsConfigure.cost == 0 ? "" : String(adsConfigure.cost))
            cellForPhoneNumber.targetTextField = TargetStateCell.cost
            cellForPhoneNumber.prepareForReuse()
            return cellForPhoneNumber
        case .specification:
            cellForDescription.changeDescription(text: adsConfigure.descriptionCar)
            return cellForDescription
        case .phoneNumber:
            cellForPhoneNumber.changeTextField(text: adsConfigure.phoneNumber == 0 ? "" : String(adsConfigure.phoneNumber))
            cellForPhoneNumber.targetTextField = TargetStateCell.phoneNumber
            cellForPhoneNumber.prepareForReuse()
            return cellForPhoneNumber
        case .photo:
            cellForPhoto.addPhotoInScroll(photo: catalogImage)
            cellForPhoto.comletion = {
                if self.catalogImage.count <= 6 {
                    self.imagePickerForAllerController()
                }
            }
            cellForPhoto.prepareForReuse()
            return cellForPhoto
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = section[indexPath.section]
        
        switch section {
        case .carBrend:
            switch ModelCars.allCases[indexPath.row] {
            case .carBrend:
                let vc = BrendCarVC()
                vc.carBrend = carBrendModel
                vc.isSearch = false
                let navVC = UINavigationController(rootViewController: vc)
                present(navVC, animated: true)
            default:
                break
            }
        case .parametrs:
            switch ParametrsForAds.allCases[indexPath.row] {
            case .typeEngine:
                presentChooseParamsVC(target: ChooseParamsEnum.typeEngine)
            case .gearbox:
                presentChooseParamsVC(target: ChooseParamsEnum.gearbox)
            case .typeDrive:
                presentChooseParamsVC(target: ChooseParamsEnum.typeDrive)
            case .condition:
                presentChooseParamsVC(target: ChooseParamsEnum.condition)
            case .year:
                presentPickerForAdsVC(isCapacity: false)
            case .capacityEngine:
                presentPickerForAdsVC(isCapacity: true)
            default:
                break
            }
        case .specification:
            let vc = TextViewVC()
            present(vc, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        CreateSectionForCreateAds.allCases[section].title
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView,
              let headerText = header.textLabel  else { return }
        headerText.textColor = .myCustomPurple
        let viewForBackground = UIView()
        header.clipsToBounds = true
        header.layer.cornerRadius = 10
        header.addSubview(viewForBackground)
        viewForBackground.frame = header.bounds
        viewForBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewForBackground.backgroundColor = .clear
        header.backgroundView = viewForBackground
    }
}

// Extentions for ImagePicker
extension AddAdsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            catalogImage.append(pickedImage)
            tableView.reloadData()
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
