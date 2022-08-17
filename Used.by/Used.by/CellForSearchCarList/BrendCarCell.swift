//
//  BrendCarCell.swift
//  Used.by
//
//  Created by Artsiom Korenko on 17.08.22.
//

import Foundation
import UIKit
import SnapKit

class BrendCarCell: UITableViewCell {

    static let key = "BrendCarCell"
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameCellLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addElementsConstraint()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }

    func changeNameCell(name: String) {
        nameCellLabel.text = name
    }
    
    func setSelectedAttribute(isSelected: Bool) {
       
    }

    private func addElementsConstraint() {
        nameCellLabel.snp.makeConstraints {
            $0.trailing.leading.bottom.top.equalToSuperview().inset(16)
        }

    }
    
    
    
    
    
}
