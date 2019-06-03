//
//  WeatherCodable.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/1/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    // MARK: - Properties
    
    let locationName: String
    let temperature: Int
    let description: String
    let iconName: String
    let windSpeed: Int
    let cloudiness: Int
    
    
    // MARK: - Coding keys
    
    enum JSONCodingKeys: String, CodingKey {
        case weather, main, name, wind, clouds
    }
    
    enum WeatherElementCodingKeys: String, CodingKey {
        case description, icon
    }
    
    enum MainCodingKeys: String, CodingKey {
        case temp
    }
    
    enum WindCodingKeys: String, CodingKey {
        case speed
    }
    
    enum CloudsCodingKeys: String, CodingKey {
        case all
    }
    
    
    // MARK: - Custom decoding init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONCodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        
        var weatherContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        var descriptions = [String]()
        var icons = [String]()
        
        while  !weatherContainer.isAtEnd {
            let weatherElementContainer = try weatherContainer.nestedContainer(keyedBy: WeatherElementCodingKeys.self)
            let description = try weatherElementContainer.decode(String.self, forKey: .description)
            descriptions.append(description)
            
            let icon = try weatherElementContainer.decode(String.self, forKey: .icon)
            icons.append(icon)
        }
        
        let mainContainer = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        let temperature = try mainContainer.decode(Double.self, forKey: .temp)
        
        let windContainer = try container.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)
        let windSpeed = try windContainer.decode(Double.self, forKey: .speed)
        
        let cloudsContainer = try container.nestedContainer(keyedBy: CloudsCodingKeys.self, forKey: .clouds)
        let cloudiness = try cloudsContainer.decode(Int.self, forKey: .all)
        
        self.locationName = name
        self.temperature = Int(temperature)
        self.description = descriptions[0].capitalized
        self.iconName = icons[0]
        self.windSpeed = Int(windSpeed)
        self.cloudiness = cloudiness
    }
}
