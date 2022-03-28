//
//  DailyWeather.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

struct DailyWeather: Decodable, Hashable {
    let date: TimeInterval
    let temp: Temp
    let weatherDetails: [WeatherDetails]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weatherDetails = "weather"
    }
}
