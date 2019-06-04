//
//  BaseListController.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-26.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
