//
//  AppsController.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-26.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController {
    
    let cellId = "appsCellId"
    let headerId = "headerId"
    
    var appGroups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .gray
        activityIndicatorView.hidesWhenStopped = true
        
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.backgroundColor = .white
        
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.fillSuperview()
        
        self.collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: self.cellId)
        
        self.collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerId)
        
        self.fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let appGroup = self.appGroups[indexPath.item]
        cell.appGroup = appGroup
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        
        header.socialApps = self.socialApps
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        let appGroupTitles = ["new-apps-we-love", "new-games-we-love", "top-free", "top-paid"]
        
        appGroupTitles.forEach { _appGroup in
            dispatchGroup.enter()
            ItunesSearchService.shared.fetchAppGroup(appGroup: _appGroup, completion: { [weak self] (result) in
                print("fetching group: \(_appGroup)")
                dispatchGroup.leave()
                switch result {
                case .success(let data):
                    self?.appGroups.append(data.feed)
                case .failure(let error):
                    print(error)
                }
            })
        }
        
        ItunesSearchService.shared.fetchSocialApps { (result) in
            switch result {
            case .success(let data):
                self.socialApps = data
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("finished fetching")
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }

}

// Size of cells
extension AppsPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}
