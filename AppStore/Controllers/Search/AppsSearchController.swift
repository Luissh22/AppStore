//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-20.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class AppsSearchController: BaseListController {
    
    private let cellId = "cellId"
    private var appResults = [ItunesApp]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please search for an app above!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEmptyState()
        self.collectionView.backgroundColor = .white
        self.collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        self.setupSearchBar()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.enterSearchTermLabel.isHidden = self.appResults.count != 0
        return self.appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell

        cell.itunesAppViewModel = ItunesAppViewModel(itunesApp: self.appResults[indexPath.item])
        
        return cell
    }
    
    private func fetchApps(searchTerm: String) {
        ItunesSearchService.shared.fetchApps(searchTerm: searchTerm) { [weak self] (result) in
            switch result {
            case .success(let searchResults):
                self?.appResults = searchResults.results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func setupEmptyState() {
        self.collectionView.addSubview(self.enterSearchTermLabel)
        self.enterSearchTermLabel.anchorCenter(x: self.collectionView.centerXAnchor)
        self.enterSearchTermLabel.anchor(top: self.collectionView.topAnchor, padding: 100)
    }
}

// Cell size
extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.view.frame.width
        let height: CGFloat = 350
        
        return CGSize(width: width, height: height)
    }
}

extension AppsSearchController: UISearchBarDelegate {
    private func setupSearchBar() {
        self.definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.fetchApps(searchTerm: searchTerm)
        })
    }
}
