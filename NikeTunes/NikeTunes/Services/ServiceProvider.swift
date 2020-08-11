//
//  ServiceProvider.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/11/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import Foundation

enum Result {
    case success(Data)
    case failure(Error)
    case unknown
}

class ServiceProvider {
    
    func getData(providerURL: URL, handler: @escaping (Result) -> Void) {
        let task = URLSession.shared.dataTask(with: providerURL) { (data, _, err) in
            if let error = err {
                handler(.failure(error))
                return
            } else if let data = data {
                handler(.success(data))
            }
            handler(.unknown)
        }
        task.resume()
    }
}
