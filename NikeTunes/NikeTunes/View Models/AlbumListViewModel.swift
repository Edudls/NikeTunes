//
//  AlbumListViewModel.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/9/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumListViewModel {
    var albums: [Album] = []
    var shouldShowExplicit: Bool = false
    var leftButtonText: String {
        return shouldShowExplicit ? "Hide Explicit" : "Show Explicit"
    }
    var albumsUrl: URL? {
        return shouldShowExplicit ? AlbumConstants.explicitUrl : AlbumConstants.albumsUrl
    }
    
    func getData(handler: @escaping () -> Void) {
        guard let url = albumsUrl else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                handler()
                return
            }
            if let jsonData = data {
                self?.decodeJsonToAlbums(data: jsonData)
            }
            handler()
        }
        task.resume()
    }
    
    func decodeJsonToAlbums(data: Data) {
        do {
            let decoder = JSONDecoder()
            let results = try decoder.decode(AlbumFeed.self, from: data)
            albums = results.feed?.results ?? []
        } catch {
            print(error)
        }
    }
    
    func getImage(imageUrlString: String, handler: @escaping (UIImage?) -> Void) {
        let imageUrl = URL(string: imageUrlString.replacingOccurrences(of: "200x200bb", with: "300x300bb"))
        guard let url = imageUrl else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                handler(nil)
                return
            }
            if let imageData = data, let image = UIImage(data: imageData) {
                handler(image)
            }
        }
        task.resume()
    }
}
