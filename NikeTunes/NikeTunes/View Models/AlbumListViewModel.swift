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
    
    func getData(handler: @escaping () -> Void) {
        let albumsUrl = shouldShowExplicit ? AlbumConstants.explicitUrl : AlbumConstants.albumsUrl
        guard let url = albumsUrl else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                handler()
                return
            }
            if let jsonData = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(AlbumFeed.self, from: jsonData)
                    print(results)
                    self?.albums = results.feed.results
                } catch {
                    print(error)
                }
            }
            handler()
        }
        task.resume()
    }
    
    func getImage(imageUrl: URL?, handler: @escaping (UIImage) -> Void) {
        guard let url = imageUrl else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            if let imageData = data, let image = UIImage(data: imageData) {
                handler(image)
            }
        }
        task.resume()
    }
}
