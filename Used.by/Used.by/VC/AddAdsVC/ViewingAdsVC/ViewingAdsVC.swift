//
//  ViewingAdsVC.swift
//  Used.by
//
//  Created by Artsiom Korenko on 30.08.22.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class ViewingAdsVC: BaseViewController {
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdsCell.self, forCellReuseIdentifier: AdsCell.key)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var spinerView: UIActivityIndicatorView = {
        var spiner = UIActivityIndicatorView()
        spiner.hidesWhenStopped = true
        return spiner
    }()

    private var realmServise: RealmServiceProtocol!
    private var alamofireServise: RestAPIProviderProtocol!
    private var searchParams = SearchSetting()
    
    var isSearch = false
    private var allAdsInfo: [AdsInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDismiss(_:)))
        swipe.direction = .right
        offLargeTitle()
        realmServise = RealmService()
        searchParams = realmServise.getSearch()
        view.addSubview(tableView)
        view.addSubview(spinerView)
        tableView.addGestureRecognizer(swipe)
        alamofireServise = AlamofireProvider()
        title = "ADS"
        view.addGestureRecognizer(swipe)
        getAllAdsId()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint()
    }
    
// MARK: Actions
   
    @objc private func swipeToDismiss(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            dismiss(animated: true)
        default:
            break
        }
    }
    
// MARK: Metods
    
// My search metods
    private func searchForParams(allAds: [AdsInfo], params: SearchSetting) -> [AdsInfo] {
        var correctArrayAds: [AdsInfo] = []
        
        if params.carBrend == "" {
            correctArrayAds = allAds
        } else {
            allAds.forEach {
                if $0.carModel == params.carModel || $0.carBrend == params.carBrend {
                    correctArrayAds.append($0)
                }
            }
        }
        
        
        if params.carModel != "" {
            var emptyArray: [AdsInfo] = []
            allAds.forEach {
                if $0.carModel == params.carModel || $0.carBrend == params.carBrend {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.yearOfProductionMax != 0 && params.yearOfProductionMin != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if (params.yearOfProductionMin...params.yearOfProductionMax).contains($0.year) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.costMin != 0 && params.costMax != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if (params.costMin...params.costMax).contains($0.cost) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.engineCapacityMax != 0 && params.engineCapacityMin != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if (params.engineCapacityMin * 1000...params.engineCapacityMax * 1000).contains(Double($0.capacity)) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.mileage != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if (0...params.mileage * 1000).contains($0.mileage) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.gearbox != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if GearBoxStruct(rawValue: params.gearbox).contains(GearBoxStruct(rawValue: $0.gearBox)) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.typeEngine != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if TypeEngimeStruct(rawValue: params.typeEngine).contains(TypeEngimeStruct(rawValue: $0.typeEngine)) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.typeDrive != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if TypeOfDriveStruct(rawValue: params.typeDrive).contains(TypeOfDriveStruct(rawValue: $0.typeDrive)) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        if params.conditionAuto != 0 {
            var emptyArray: [AdsInfo] = []
            correctArrayAds.forEach {
                if ConditionStruct(rawValue: params.conditionAuto).contains(ConditionStruct(rawValue: $0.condition)) {
                    emptyArray.append($0)
                }
            }
            correctArrayAds = emptyArray
        }
        
        tableView.reloadData()
        return correctArrayAds
    }
    
    
    
    
    private func getAllAdsId() {
        alamofireServise.getAllAdsId { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.getInfoAllAds(adsId: value.id)
            case .failure:
                print("No ok")
            }
        }
    }
    
    private func getInfoAllAds(adsId: [String]) {
        let group = DispatchGroup()
        spinerView.startAnimating()
        for id in adsId {
            group.enter()
            alamofireServise.getAdsInfo(id: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.allAdsInfo.append(value)
                    group.leave()
                case .failure:
                    print("No ok po id")
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            if self.isSearch {
                self.allAdsInfo = self.searchForParams(allAds: self.allAdsInfo, params: self.searchParams)
            }
            self.tableView.reloadData()
            self.spinerView.stopAnimating()
        }
    }
    
    @objc private func searchButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func addConstreint() {
    
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
        }
        
        spinerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
        }
    }
}

extension ViewingAdsVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allAdsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdsCell.key) as? AdsCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.changeSmallDescription(adsInfo: allAdsInfo[indexPath.row])
        cell.updateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AdsVC()
        vc.adsInfo = allAdsInfo[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
