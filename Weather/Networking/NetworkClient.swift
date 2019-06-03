//
//  NetworkClient.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/1/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation
import CoreLocation

enum NetworkClientError: Error {
    case networkError
    case dataError
    case decodingError
}

class NetworkClient {
    
    private let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    private let apiKey = "08f25e735b7f7fb300b1e72ff7775791"
    
    func fetchWeatherByCity(name: String, completion: @escaping (Weather?, NetworkClientError?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let cityNameQuery = URLQueryItem(name: "q", value: name)
        let unitQuery = URLQueryItem(name: "units", value: "imperial")
        let apiKeyQuery = URLQueryItem(name: "appid", value: apiKey)
        components.queryItems = [cityNameQuery, unitQuery, apiKeyQuery]
        
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                NSLog("fetchWeatherByCityName Error performing data task: \(error)")
                completion(nil, .networkError)
            }
            
            if let response = response as? HTTPURLResponse {
                NSLog("fetchWeatherByCityName HTTP response: \(response.statusCode)")
            }
            
            guard let data = data else {
                NSLog("fetchWeatherByCityName No data returned")
                completion(nil, .dataError)
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(weather, nil)
                }
            } catch {
                NSLog("fetchWeatherByCityName Decoding error: \(error)")
                completion(nil, .decodingError)
            }
        }.resume()
    }
    
    func fetchWeatherBy(location: Coordinate, completion: @escaping (Weather?, NetworkClientError?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let latQuery = URLQueryItem(name: "lat", value: "\(location.lat)")
        let lonQuery = URLQueryItem(name: "lon", value: "\(location.lon)")
        let unitQuery = URLQueryItem(name: "units", value: "imperial")
        let apiKeyQuery = URLQueryItem(name: "appid", value: apiKey)
        components.queryItems = [latQuery, lonQuery, unitQuery, apiKeyQuery]
        
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                NSLog("fetchWeatherByLocation Error performing data task: \(error)")
                completion(nil, .networkError)
            }
            
            if let response = response as? HTTPURLResponse {
                NSLog("fetchWeatherByLocation HTTP response: \(response.statusCode)")
            }
            
            guard let data = data else {
                NSLog("fetchWeatherByLocation No data returned")
                completion(nil, .dataError)
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(weather, nil)
                }
            } catch {
                NSLog("fetchWeatherByLocation Decoding error: \(error)")
                completion(nil, .decodingError)
            }
        }.resume()
    }
}
