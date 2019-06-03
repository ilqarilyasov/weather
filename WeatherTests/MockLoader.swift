//
//  MockLoader.swift
//  WeatherTests
//
//  Created by Ilgar Ilyasov on 6/3/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation
@testable import Weather

/* This structure will let us use any mock data and error
 * So we will assume that the network call will work fine
 * And we can only test our own logic without depending outside factors
 * This is useful for testing decoding, encoding and other important logics */

struct MockLoader: NetworkDataLoader {
    let data: Data?
    let error: Error?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.global().async {
            completion(self.data, nil, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.global().async {
            completion(self.data, nil, self.error)
        }
    }
}
