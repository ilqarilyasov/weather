//
//  ImageLoader.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/1/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    // MARK: - Properties
    
    private let baseImageURL = URL(string: "https://openweathermap.org/img/w")!
    let networkDataLoader: NetworkDataLoader?
    
    
    // MARK: - Initializer
    
    init(networkDataLoader: NetworkDataLoader? = URLSession.shared) {
        self.networkDataLoader = networkDataLoader
    }
    
    
    // MARK: - Load image
    
    func loadImage(name: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let url = baseImageURL.appendingPathComponent(name).appendingPathExtension("png")
        
        networkDataLoader?.loadData(from: url) { (data, response, error) in
            if let error = error {
                NSLog("Error performing data task: \(error)")
                completion(nil, error)
            }
            
            if let response = response as? HTTPURLResponse {
                NSLog("loadImage HTTP response: \(response.statusCode)")
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(nil, NSError())
                return
            }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image, nil)
            }
        }
    }
}
