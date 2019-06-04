//
//  ItunesSearchResult.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-20.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import Foundation

struct ItunesApp: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
}

struct ItunesSearchResult: Decodable {
    let resultCount: Int
    let results: [ItunesApp]
}

struct ItunesAppViewModel {
    let appName: String
    let category: String
    let rating: String
    let appIconUrl: URL?
    let screenshotUrls: [URL]
    
    init(itunesApp: ItunesApp) {
        self.appName = itunesApp.trackName
        self.category = itunesApp.primaryGenreName
        self.rating = "Rating: \(itunesApp.averageUserRating ?? 0)"
        self.appIconUrl = URL(string: itunesApp.artworkUrl100)
        self.screenshotUrls = itunesApp.screenshotUrls.compactMap { URL(string: $0) }
    }
}

