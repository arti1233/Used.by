//
//  LookPhotoAds.swift
//  Used.by
//
//  Created by Artsiom Korenko on 11.09.22.
//

import Foundation
import SnapKit
import UIKit

class LookPhotoVC: BaseViewController, UIScrollViewDelegate {

    static let key = "LookPhotoVC"
    
    private lazy var myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .mainBackgroundColor
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        return scrollView
    }()

//  добавление stackView кодом
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private var newScroll = UIScrollView()
    private var newView = UIView()
    private var imageView = UIImageView()
    var arrayImages: [UIImage] = []
    var titleName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItems = [UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed(sender:)))]
        title = titleName
        view.addSubview(myScrollView)
        myScrollView.addSubview(stackView)
        
        for (index, element) in arrayImages.enumerated() {
            newScroll = UIScrollView()
            stackView.addArrangedSubview(newScroll)
            newScroll.snp.makeConstraints {
                $0.width.equalTo(view.snp.width)
                $0.height.equalTo(view.safeAreaLayoutGuide.snp.height)
            }
            
            newView = UIView()
            newScroll.addSubview(newView)
            newView.snp.makeConstraints {
                $0.width.equalTo(view.snp.width)
                $0.height.equalTo(view.safeAreaLayoutGuide.snp.height)
            }
            
            imageView = UIImageView()
            imageView.image = element
            imageView.contentMode = .scaleAspectFit
            newView.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.width.equalTo(view.snp.width)
                $0.height.equalTo(view.safeAreaLayoutGuide.snp.height)
            }
            
            imageView.tag = index + 1
            newScroll.delegate = self
            newScroll.minimumZoomScale = 1
            newScroll.maximumZoomScale = 5
        }
    }
    
    @objc private func backButtonPressed(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        myScrollView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        stackView.snp.makeConstraints {
            $0.trailing.leading.bottom.top.equalToSuperview()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let page = Int(myScrollView.contentOffset.x / myScrollView.frame.size.width) + 1
        let image = view.viewWithTag(page)
        title = "Photo \(page) in \(arrayImages.count)"
        return image
    }
        
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = scrollView.zoomScale == 1
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale < 0 || scale > 4 {
            scrollView.zoomScale = 1
        }
    }
}

