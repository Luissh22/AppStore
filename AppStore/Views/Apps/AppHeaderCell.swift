//
//  AppHeaderCell.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-26.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class AppHeaderCell: UICollectionViewCell {
    
    var socialAppViewModal: SocialAppViewModel? {
        didSet {
            guard let viewModel = socialAppViewModal, let imageUrl = viewModel.imageUrl else { return }
            self.companyLabel.text = viewModel.companyName
            self.descriptionLabel.text = viewModel.description
            self.imageView.sd_setImage(with: imageUrl)
        }
    }
    
    let companyLabel: UILabel = {
        let label = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
        label.textColor = .blue
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
        
        label.numberOfLines = 2
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 8)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(arrangedSubviews: [self.companyLabel, self.descriptionLabel, self.imageView], spacing: 10)
        
        self.addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


