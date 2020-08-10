//
//  Album.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/8/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

struct Album: Codable {
    let artistName: String?
    let releaseDate: String?
    let name: String?
    let copyright: String?
    let artworkUrl: String?
    let genres: [Genre]?
    let storeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case releaseDate
        case name
        case copyright
        case artworkUrl = "artworkUrl100"
        case genres
        case storeUrl = "url"
    }
}

struct Genre: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct AlbumResults: Codable {
    let results: [Album]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct AlbumFeed: Codable {
    let feed: AlbumResults?
    
    enum CodingKeys: String, CodingKey {
        case feed
    }
}
