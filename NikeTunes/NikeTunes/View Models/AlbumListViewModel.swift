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
    var imageDictionary: [String: UIImage] = [:]
    var shouldShowExplicit: Bool = false
    var serviceProvider = ServiceProvider()
    var leftButtonText: String {
        return shouldShowExplicit ? "Hide Explicit" : "Show Explicit"
    }
    var albumsUrl: URL? {
        return shouldShowExplicit ? AlbumConstants.explicitUrl : AlbumConstants.albumsUrl
    }
    
    func getData(handler: @escaping () -> Void) {
        guard let url = albumsUrl else {
            handler()
            return
        }
        
        serviceProvider.getData(providerURL: url) { [weak self] (result) in
            if case .success(let jsonData) = result {
                self?.decodeJsonToAlbums(data: jsonData)
            } else if case .failure(let error) = result {
                print(error.localizedDescription)
            }
            handler()
        }
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
        
        if let image = imageDictionary[imageUrlString] {
            handler(image)
            return
        }
        
        let imageUrl = URL(string: imageUrlString.replacingOccurrences(of: "200x200bb", with: "300x300bb"))
        guard let url = imageUrl else {
            handler(nil)
            return
        }
        
        serviceProvider.getData(providerURL: url) { [weak self] (result) in
            if case .success(let imageData) = result {
                let image = UIImage(data: imageData)
                self?.imageDictionary[imageUrlString] = image
                handler(image)
            }
        }
    }
}
