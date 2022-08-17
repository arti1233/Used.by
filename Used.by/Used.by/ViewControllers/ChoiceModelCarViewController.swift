//
//  ChoiceModelCarViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 17.08.22.
//

import UIKit
import Foundation
import SnapKit

class ChoiceModelCarViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .purple
        return tableView
    }()
    
    var model = CarBrend.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        title = "Model"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BrendCarCell.self, forCellReuseIdentifier: BrendCarCell.key)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addElementsForView()
    }
    
    private func addElementsForView() {
        tableView.snp.makeConstraints {
            guard let tabBar = tabBarController?.tabBar.frame.height else { return }
            $0.bottom.equalToSuperview().inset(tabBar)
            $0.trailing.leading.equalToSuperview().inset(0)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(0)
        }
    }
}

extension ChoiceModelCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrendCarCell.key) as? BrendCarCell else { return UITableViewCell() }
        cell.layoutSubviews()
        cell.changeNameCell(name: model.allCases[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch model.allCases[indexPath.row] {
        case .alfaRomeo:
            print("")
        case .dodge:
            print("")
        case .kia:
            print("")
        case .nissan:
            print("")
        case .skoda:
            print("")
        case .audi:
            print("")
        case .fiat:
            print("")
        case .lada:
            print("")
        case .opel:
            print("")
        case .subaru:
            print("")
        case .bmv:
            print("")
        case .ford:
            print("")
        case .lexus:
            print("")
        case .peugeot:
            print("")
        case .suzuki:
            print("")
        case .chevrolet:
            print("")
        case .geely:
            print("")
        case .mazda:
            print("")
        case .renault:
            print("")
        case .toyota:
            print("")
        case .chrysler:
            print("")
        case .honda:
            print("")
        case .mercedesBenz:
            print("")
        case .rover:
            print("")
        case .volkswagen:
            print("")
        case .citroen:
            print("")
        case .hyundai:
            print("")
        case .mitsubishi:
            print("")
        case .seat:
            print("")
        case .volvo:
            print("")
        }
    }
    
}
