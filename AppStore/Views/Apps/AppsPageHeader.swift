//
//  AppsPageHeader.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-26.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    var socialApps = [SocialApp]() {
        didSet {
            self.appHeaderHorizontalController.socialApps = socialApps
        }
    }
    
    private let appHeaderHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        self.addSubview(self.appHeaderHorizontalController.view)
        self.appHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
