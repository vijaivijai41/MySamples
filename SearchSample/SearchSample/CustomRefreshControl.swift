//
//  CustomLoader.swift
//  SearchSample
//
//  Created by vijay kumar on 20/09/21.
//

import Foundation
import UIKit


class CustomRefreshControl: UIRefreshControl {
    
    lazy var customImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        var images: [UIImage] = []
        for i in 1...10 {
            images.append(UIImage(named: "\(i).png")!)
        }
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        self.addSubview(imageView)
        return imageView
    }()

    override func beginRefreshing() {
        super.beginRefreshing()
        customImage.startAnimating()
    }

    override init() {
        super.init()
        customImage.startAnimating()
        self.tintColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        customImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        customImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        customImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
}
