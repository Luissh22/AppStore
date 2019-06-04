//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-26.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    var appGroup: AppGroup? {
        didSet {
            guard let title = appGroup?.title, let results = appGroup?.results else { return }
            self.titleLabel.text = "\(title)"
            self.horizontalCellController.appGroupResults = results
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel(text: "App Section", font: UIFont.boldSystemFont(ofSize: 30))
        
        return label
    }()
    
    private let horizontalCellController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        self.addSubview(self.horizontalCellController.view)
        
        self.horizontalCellController.view.anchor(top: self.titleLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
