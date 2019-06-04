//
//  ItunesAppGroup.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-28.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import Foundation

struct ItunesAppGroupResult: Decodable {
    let feed: AppGroup
}

struct AppGroup: Decodable {
    let title: String
    let results: [AppGroupResult]
}

struct AppGroupResult: Decodable {
    let artistName: String
    let name: String
    let artworkUrl100: String
}

struct AppGroupResultViewModel {
    let appName: String
    let companyName: String
    let appIconUrl: URL?
    
    init(appGroupResult: AppGroupResult) {
        self.appName = appGroupResult.name
        self.companyName = appGroupResult.artistName
        self.appIconUrl = URL(string: appGroupResult.artworkUrl100)
    }
}

struct SocialApp: Decodable {
    let id, name, imageUrl, tagline: String
}

struct SocialAppViewModel {
    let companyName, description: String
    let imageUrl: URL?
    
    init(socialApp: SocialApp) {
        self.companyName = socialApp.name
        self.description = socialApp.tagline
        self.imageUrl = URL(string: socialApp.imageUrl)
    }
}
