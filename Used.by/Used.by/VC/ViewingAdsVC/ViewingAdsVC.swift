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
        tableView.backgroundColor = .purple
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
    
    private var alamofireServise: RestAPIProviderProtocol!
    
    private var arrayId: [String] = []
    private var adsInfo: AdsInfo!
    private var allAdsInfo: [AdsInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDismiss(_:)))
        swipe.direction = .right
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
   
    @objc func swipeToDismiss(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            dismiss(animated: true)
        default:
            break
        }
    }
    
// MARK: Metods
 
    func getAllAdsId() {
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
                    self.adsInfo = value
                    self.allAdsInfo.append(value)
                    print(self.allAdsInfo)
                    group.leave()
                case .failure:
                    print("No ok po id")
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
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
        let info = allAdsInfo[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.changeTitleCell(adsInfo: info)
        cell.changeSmallDescription(adsInfo: info)
        cell.updateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AdsVC()
        let info = allAdsInfo[indexPath.row]
        vc.adsInfo = info
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
