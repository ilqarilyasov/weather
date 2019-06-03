//
//  NetworkDataLoader.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/3/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

/* This protocol is going to be usefull when we're testing a network call
 * and let us alter URLSession's behaviour based on our needs
 * We can test our code without depending on URLSession default behaviour */

protocol NetworkDataLoader {
    func loadData(from request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    func loadData(from url: URL,
                  completion: @escaping (Data?, URLResponse? , Error?) -> Void)
}

extension URLSession: NetworkDataLoader {
    func loadData(from request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: request, completionHandler: completion).resume()
    }
    
    func loadData(from url: URL,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: url, completionHandler: completion).resume()
    }
}
