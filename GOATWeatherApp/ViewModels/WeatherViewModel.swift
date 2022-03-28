//
//  WeatherViewModel.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation
import UIKit
import CoreLocation

class WeatherViewModel {
    
    // MARK: - Properties
    var dailyWeatherCellPresentation = [WeatherCellPresentation]() {
        didSet {
            if dailyWeatherCellPresentation[0].iconImage == nil { // we only want to fetch if there aren't any
                fetchImages()
            }
            reloadTableView?()
        }
    }
    
    var userCoordinates: UserCoordinates? {
        didSet {
            fetchWeatherData(latitude: userCoordinates?.latitude ?? -20, longitude: userCoordinates?.longitude ?? -25)
            reloadTableView?()
        }
    }
    
    //    var isLoading: Bool = false -> this would be used to controller an activity view controller to indicate loading
    let weatherService: WeatherService
    var reloadTableView: (() -> Void)?
    
    // MARK: - Init
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        //        isLoading = true
        let userCoordinates = UserCoordinates(latitude: latitude, longitude: longitude)
        weatherService.getWeather(using: userCoordinates) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let dailyWeatherData = self.dailyWeatherDataToPresentation(response)
                self.dailyWeatherCellPresentation = dailyWeatherData
                //                    self.isLoading = false
            case .failure(let error):
                print("DEBUG failed to fetchData because: \(error.localizedDescription)")
                //                self.isLoading = false
            }
        }
    }
    
    func fetchImages() {
        //        isLoading = true
        let imagesURL = generateImagesURL()
        weatherService.getImages(using: imagesURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let images):
                let cellPresentationWithImage = self.dailyWeatherToPresentationWithImages(images)
                self.dailyWeatherCellPresentation = cellPresentationWithImage
                //                    self.isLoading = false
                
            case .failure(let error):
                print("DEBUG: Error getting images with: \(error.localizedDescription)")
                //                self.isLoading = false
            }
        }
    }
    
    func fetchCellData(at indexPath: IndexPath) -> WeatherCellPresentation {
        return self.dailyWeatherCellPresentation[indexPath.row]
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality, error)
        }
    }
}

private extension WeatherViewModel {
    // Format weather response into model for UI
    func dailyWeatherDataToPresentation(_ weatherData: WeatherResponse) -> [WeatherCellPresentation] {
        var weatherCell: [WeatherCellPresentation] = []
        for data in weatherData.dailyWeather {
            let weekDay = Date(timeIntervalSince1970: data.date).dayOfWeek()
            let roundedMinTemp = Int(floor(data.temp.min))
            let roundedMaxTemp = Int(floor(data.temp.max))
            let temp = "MIN: \(roundedMinTemp) MAX: \(roundedMaxTemp)"
            let iconName = data.weatherDetails.first?.icon ?? ""
            let shortDate = Date(timeIntervalSince1970: data.date).shortDateFormat()
            let weatherDetails = data.weatherDetails.first
            weatherCell.append(WeatherCellPresentation(currentDate: shortDate, weekDay: weekDay ?? "", temp: temp, iconName: iconName, iconImage: nil, weatherDetails: weatherDetails))
        }
        return weatherCell
    }
    
    //Update current UI model with images
    func dailyWeatherToPresentationWithImages(_ images: [UIImage]) -> [WeatherCellPresentation] {
        var weatherCell: [WeatherCellPresentation] = []
        // just to be safe dont want app to crash in case index is out of range, this will make sure that won't happen
        if images.count != dailyWeatherCellPresentation.count { return self.dailyWeatherCellPresentation }
        
        for (index, _) in images.enumerated() {
            let weekDay = dailyWeatherCellPresentation[index].weekDay
            let temp = dailyWeatherCellPresentation[index].temp
            let iconName = dailyWeatherCellPresentation[index].iconName
            let shortDate = dailyWeatherCellPresentation[index].currentDate
            let iconImage = images[index]
            let weatherDetails = dailyWeatherCellPresentation[index].weatherDetails
            weatherCell.append(WeatherCellPresentation(currentDate: shortDate, weekDay: weekDay, temp: temp, iconName: iconName, iconImage: iconImage, weatherDetails: weatherDetails))
            
        }
        return weatherCell
    }
    
    func generateImagesURL() -> [String] {
        var imagesUrl: [String] = []
        for daily in dailyWeatherCellPresentation {
            let url = "http://openweathermap.org/img/wn/\(daily.iconName)@2x.png"
            imagesUrl.append(url)
        }
        return imagesUrl
    }
}
