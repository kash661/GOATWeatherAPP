//
//  WeatherDetailViewModel.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

class WeatherDetailViewModel {
    
    var weatherDescriptionData: WeatherDetails

    init(weatherDescriptionData: WeatherDetails) {
        self.weatherDescriptionData = weatherDescriptionData
    }
}
