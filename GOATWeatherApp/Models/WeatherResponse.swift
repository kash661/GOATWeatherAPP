//
//  WeatherResponse.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

struct WeatherResponse: Decodable {
    
    let currentTemp: Double
    let currentDate: Double
    let dailyWeather: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case current, daily
    }
    
    enum CurrentCodingKeys: String, CodingKey {
        case temp, dt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let currentContainer = try container.nestedContainer(keyedBy: CurrentCodingKeys.self, forKey: .current)
        currentTemp = try currentContainer.decode(Double.self, forKey: .temp)
        currentDate = try currentContainer.decode(Double.self, forKey: .dt)
        dailyWeather = try container.decode([DailyWeather].self, forKey: .daily)
    }
}
