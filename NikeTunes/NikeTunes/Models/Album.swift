//
//  Album.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/8/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

struct Album: Codable {
    let artistName: String
    let releaseDate: String
    let name: String
    let artworkUrl: String
    let storeUrl: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case releaseDate
        case name
        case artworkUrl = "artworkUrl100"
        case storeUrl = "url"
    }
}

struct AlbumResults: Codable {
    let results: [Album]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct AlbumFeed: Codable {
    let feed: AlbumResults
    
    enum CodingKeys: String, CodingKey {
        case feed
    }
}
