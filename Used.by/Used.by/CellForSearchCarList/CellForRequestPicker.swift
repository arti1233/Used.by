//
//  CellForReqestPicker.swift
//  Used.by
//
//  Created by Artsiom Korenko on 16.08.22.
//

import Foundation
import SnapKit
import UIKit


class CellForRequestPicker: UITableViewCell {
    
    static let key = "CellForReqestPicker"
    
    private lazy var fieldNameLabel: CustomUILabel = {
        var label = CustomUILabel()
        return label
    }()
    
    private lazy var resultChoiceLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.text = "BMW"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(fieldNameLabel)
        contentView.addSubview(resultChoiceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        addFieldName()
        addResultChoiceLabel()
    }
    
    func changeFieldName(name: String) {
        fieldNameLabel.text = name
    }

    private func addFieldName() {
        fieldNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func addResultChoiceLabel () {
        
        resultChoiceLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        fieldNameLabel.snp.makeConstraints {
            fieldNameLabel.font = UIFont.systemFont(ofSize: 17)
            $0.bottom.equalTo(resultChoiceLabel.snp.top)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
        }
    }
    
}
    
    
