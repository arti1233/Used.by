//
//  CollectionCellForPhoto.swift
//  Used.by
//
//  Created by Artsiom Korenko on 13.09.22.
//

import UIKit
import SnapKit

class CollectionCellForPhoto: UICollectionViewCell {
    
    static var key = "CollectionCellForPhoto"
    
    private var imageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.subviews.forEach({$0.removeFromSuperview()})
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func changeImage(image: UIImage) {
        imageView.image = image
    }
}
