//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/1/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

struct WeatherViewModel {
    
    let locationName: String
    let temperature: Int
    let description: String
    let icon: String
    let windSpeed: Int
    let clouds: Int
    
    init(weather: Weather) {
        self.locationName = weather.locationName
        self.temperature = weather.temperature
        self.description = weather.description
        self.icon = weather.iconName
        self.windSpeed = weather.windSpeed
        self.clouds = weather.cloudiness
    }
}
