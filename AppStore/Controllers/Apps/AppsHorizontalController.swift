//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-26.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController {
    
    let cellId = "horizontalCellId"
    
    var appGroupResults = [AppGroupResult]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        
        // make horizontal scrolling
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appGroupResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        
        cell.appGroup = AppGroupResultViewModel(appGroupResult: self.appGroupResults[indexPath.item])
    
        return cell
    }
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    
    var verticalPadding: CGFloat {
        return 12
    }
    
    var lineSpacing: CGFloat {
        return 10
    }
    
    var numCellsPerColumn: CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // need to account for padding & spacing
        let padding = self.verticalPadding * 2
        let lineSpacingPadding = self.lineSpacing * (self.numCellsPerColumn - 1)
        let height = (self.view.frame.height - padding - lineSpacingPadding) / self.numCellsPerColumn
        let width = self.view.frame.width - 40
        return CGSize(width: width, height: height)
    }
    
    // Cell line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.lineSpacing
    }
    
    // Cell contiainer padding (not individual cells)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.verticalPadding, left: 16, bottom: self.verticalPadding, right: 16)
    }
}
