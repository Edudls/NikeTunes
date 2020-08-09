//
//  AlbumConstants.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/8/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import Foundation
struct AlbumConstants {
    static let albumsUrl: URL? = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/non-explicit.json")
    static let explicitUrl: URL? = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
}
