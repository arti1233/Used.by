//
//  CellForReqestPicker.swift
//  Used.by
//
//  Created by Artsiom Korenko on 16.08.22.
//

import Foundation
import SnapKit
import UIKit


class CellForRequestView: UITableViewCell {
    
    static let key = "CellForRequestView"
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .myColorForCell
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var fieldNameLabel: CustomUILabel = {
        var label = CustomUILabel()
        return label
    }()
    
    private lazy var resultChoiceLabel: CustomUILabel = {
        var label = CustomUILabel()
        return label
    }()

//MARK: Override functions 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        addConstreint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.backgroundColor = .myColorForCell
        resultChoiceLabel.text = ""
    }

//MARK: Metods
    func changeFieldName(name: String) {
        fieldNameLabel.text = name
    }
    
    func changeResultLabel(name: String) {
        resultChoiceLabel.text = name
    }
    
    func changeColorView() {
        mainView.backgroundColor = .myLightGray
    }

//MARK: Metods for Constreint
    private func addConstreint() {
        mainView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
        }
        
        resultChoiceLabel.snp.makeConstraints {
            $0.centerX.equalTo(mainView.snp.centerX)
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
    
    private func addElements() {
        contentView.addSubview(mainView)
        mainView.addSubview(fieldNameLabel)
        mainView.addSubview(resultChoiceLabel)
    }
}
    
    
