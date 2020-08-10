//
//  AlbumDetailViewModel.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/9/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumDetailViewModel {
    var album: Album?
    
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
