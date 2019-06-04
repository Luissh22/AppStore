//
//  AppRowCell.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-26.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

class AppRowCell: UICollectionViewCell {
    
    var appGroup: AppGroupResultViewModel? {
        didSet {
            guard let appGroup = appGroup, let appIconUrl = appGroup.appIconUrl else { return }
            
            self.appNameLabel.text = appGroup.appName
            self.companyNameLabel.text = appGroup.companyName
            self.appImageView.sd_setImage(with: appIconUrl)
        }
    }
    
    let appImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 8)
        imageView.backgroundColor = .purple
        imageView.anchorSize(width: 64, height: 64)
        return imageView
    }()
    
    let appNameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 18))

    let companyNameLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    let getButton: UIButton = {
        let button = UIButton(title: "GET")
        button.anchorSize(width: 80, height: 32)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStackView = VerticalStackView(arrangedSubviews: [self.appNameLabel, self.companyNameLabel])
        
        let rowStackView = UIStackView(arrangedSubviews: [self.appImageView, labelStackView, self.getButton])
        rowStackView.axis = .horizontal
        rowStackView.spacing = 16
        rowStackView.alignment = .center // centers perpendicular to layout axis
        
        self.addSubview(rowStackView)
        rowStackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
