//
//  ItunesSearchService.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-20.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case urlParsingError
    case jsonParseError(reason: String)
    case resourceNotFound
    case networkError(reason: String)
}

class ItunesSearchService {
    // Singleton
    static let shared = ItunesSearchService()
    
    func fetchApps(searchTerm: String, completion: @escaping (Result<ItunesSearchResult, Error>) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        self.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping (Result<[SocialApp], Error>) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        self.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchAppGroup(appGroup: String, completion: @escaping (Result<ItunesAppGroupResult, Error>) -> ()) {
         let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/\(appGroup)/all/50/explicit.json"
        
        self.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchJSONData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
      
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlParsingError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(NetworkError.networkError(reason: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.resourceNotFound))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.jsonParseError(reason: error.localizedDescription)))
            }
        }.resume()
        
    }
    
    private init() {
        print("Init service")
    }
}
