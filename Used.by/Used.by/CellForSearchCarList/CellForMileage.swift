//
//  TableViewCell.swift
//  Used.by
//
//  Created by Artsiom Korenko on 18.08.22.
//

import Foundation
import UIKit
import SnapKit


class CellForMileage: UITableViewCell {

    static let key = "CellForMileage"
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.text = "asd"
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameCellLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        addConstreit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func changeNameCell(name: String) {
        nameCellLabel.text = name
    }

    fileprivate func addConstreit() {
        
        nameCellLabel.snp.makeConstraints {
            $0.trailing.leading.bottom.top.equalToSuperview().inset(16)
        }
    }
    
}
