//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-20.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    var itunesAppViewModel: ItunesAppViewModel? {
        didSet {
            guard let viewModel = itunesAppViewModel, let appIconUrl = viewModel.appIconUrl else { return }
            
            self.nameLabel.text = viewModel.appName
            self.categoryLabel.text = viewModel.category
            self.ratingsLabel.text = viewModel.rating
            self.appIconImageView.sd_setImage(with: appIconUrl)
         
            for (index, element) in self.screenshotImageViews.enumerated() {
                if (index >= viewModel.screenshotUrls.count) { continue }
                element.sd_setImage(with: viewModel.screenshotUrls[index])
            }
            
        }
    }
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.anchorSize(width: 64, height: 64)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Video"
        
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 12
        button.anchorSize(width: 80, height: 0)
        
        return button
    }()
    
    lazy var screenshotImageViews = [self.createScreenshotImageView(),
                                     self.createScreenshotImageView(),
                                     self.createScreenshotImageView()]
    
    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let appInfoStackView = self.generateAppInfoStackView()
        
        let screenshotStackView = self.generateScreenshotStackView()
        
        let containerStackView = VerticalStackView(arrangedSubviews: [appInfoStackView, screenshotStackView], spacing: 16)
        
        self.addSubview(containerStackView)
        
        containerStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateLabelsStackView() -> UIStackView {
        return VerticalStackView(arrangedSubviews: [
            self.nameLabel, self.categoryLabel, self.ratingsLabel
            ])
    }
    
    private func generateAppInfoStackView() -> UIStackView {
        let labelsStackView = self.generateLabelsStackView()
        let appInfoStackView = UIStackView(arrangedSubviews: [
            self.appIconImageView, labelsStackView, self.getButton
            ])
        
        appInfoStackView.spacing = 12
        appInfoStackView.axis = .horizontal
        appInfoStackView.alignment = .center
        
        return appInfoStackView
    }
    
    private func generateScreenshotStackView() -> UIStackView {
        let screenshotStackView = UIStackView(arrangedSubviews: self.screenshotImageViews)
        screenshotStackView.axis = .horizontal
        screenshotStackView.spacing = 10
        screenshotStackView.distribution = .fillEqually
        
        return screenshotStackView
    }
}
