//
//  NetworkController.swift
//  Itunes-Nike
//
//  Created by Johnny Hicks on 8/9/19.
//  Copyright © 2019 Swiftly, LLC. All rights reserved.
//

import Foundation

struct Feed: Decodable {
    var feed: Albums
    
    struct Albums: Decodable {
        var results: [Album]
        
    }
}

struct Album: Decodable {
    var artistName: String
    var name: String
    var copyright: String
    var artworkUrl100: String
    var genres: [Genre]
    
    struct Genre: Decodable {
        var name: String
    }
}



class NetworkController {
    
    let baseURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")!
    
    func fetchItunesData(completion: @escaping (Feed?) -> ()) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                NSLog("No data")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Feed.self, from: data)
                let albums = results.re
                print("\(results)")
            } catch let error {
                print("There was an error decoding your data:%@", error)
                return
            }
            }.resume()
        
    }
}





