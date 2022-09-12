//
//  PopUpWithParametrsViewController .swift
//  Used.by
//
//  Created by Artsiom Korenko on 20.08.22.
//

import Foundation
import UIKit
import Foundation
import SnapKit

class ChooseMileageVC: BaseViewController {

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellForMileage.self, forCellReuseIdentifier: CellForMileage.key)
        return tableView
    }()
    
    private lazy var titleName: UILabel = {
        var titleName = UILabel()
        titleName.textColor = UIColor.myCustomPurple
        titleName.textAlignment = .left
        titleName.text = "Model"
        titleName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return titleName
    }()

    private lazy var closeButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .myCustomPurple
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        return button
    }()
    
    // для того чтобы не писать массивы в ручную 
    private let array = Array (1...50)
    private var arrayMilegeInt: [Int] = []
    private var arrayMilegeString: [String] = []
    private var realmServise: RealmServiceProtocol!
    var isSearch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmServise = RealmService()
        addElements()
        arrayMilegeInt = array.map({$0 * 10})
        arrayMilegeString = arrayMilegeInt.map({"from \($0) thousands km "})
    }
    
    @objc fileprivate func closeVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint()
    }
    
    
// MARK: Metod for constreint
    private func addConstreint() {
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
        
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(0)
            $0.top.equalToSuperview().inset(65)
        }
    }
    
    private func addElements() {
        view.addSubview(titleName)
        view.addSubview(tableView)
        view.addSubview(closeButton)
    }
    
//MARK: Metod
    func changeTitleName(name: String) {
        titleName.text = name
    }
}

extension ChooseMileageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayMilegeString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForMileage.key) as? CellForMileage else { return UITableViewCell() }
        cell.updateConstraints()
        cell.changeNameCell(name: arrayMilegeString[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearch {
            realmServise.addObjectInSearchSetting(mileage: arrayMilegeInt[indexPath.row])
        } else {
            realmServise.addAdsParams(mileage: arrayMilegeInt[indexPath.row])
        }
        dismiss(animated: true)
    }

}

