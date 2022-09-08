//
//  CellForAdsPhoto.swift
//  Used.by
//
//  Created by Artsiom Korenko on 2.09.22.
//

import Foundation
import UIKit
import SnapKit

class CellForAdsPhoto: UITableViewCell {

    static let key = "CellForAdsPhoto"
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.text = "Add photo in ads"
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.contentSize = CGSize(width: 150, height: 150)
        return scroll
    }()
    
    private lazy var chooseButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Choose photo", for: .normal)
        button.addTarget(self, action: #selector(chooseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()

    var comletion: (() -> Void)?
    private var imagesView: [UIImageView] = []
    
    
//MARK: Override func
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        addElementsConstraint()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: Metods
    // Pressed on the button
    @objc private func chooseButtonPressed(sender: UIButton){
        guard let comletion = comletion else { return }
        comletion()
    }
    
    // Change name cell
    func changeNameCell(name: String) {
        nameCellLabel.text = name
    }
    
    // Add photo in scroll view
    func addPhotoInScroll(photo: [UIImage]) {
        if photo.isEmpty {
            scrollView.snp.makeConstraints {
                $0.top.equalTo(nameCellLabel.snp.bottom).offset(16)
                $0.height.equalTo(0)
                $0.trailing.leading.equalToSuperview().inset(16)
            }
        }
        
        photo.forEach({stackView.addArrangedSubview((UIImageView(image: $0)))})
        for images in stackView.arrangedSubviews {
            images.snp.makeConstraints {
                $0.width.height.equalTo(150)
            }
        }
    }
    
    // Add elements on the view
    func addElements() {
        contentView.addSubview(nameCellLabel)
        scrollView.addSubview(stackView)
        contentView.addSubview(scrollView)
        contentView.addSubview(chooseButton)
    }
    
//MARK: Constreint
    private func addElementsConstraint() {
        nameCellLabel.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview().inset(16)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(nameCellLabel.snp.bottom).offset(16)
            $0.height.equalTo(150)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(scrollView)
        }
        
        chooseButton.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview().inset(16)
            $0.top.equalTo(scrollView.snp.bottom).offset(16)
            $0.height.equalTo(50)
        }
    }
}
