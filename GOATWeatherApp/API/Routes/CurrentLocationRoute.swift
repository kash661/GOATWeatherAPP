//
//  CurrentLocationRoute.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

struct CurrentLocationRoute: APIRoute {
    private let userCoordinates: UserCoordinates
    var path: String { "/data/2.5/onecall" }
    
    var method: HTTPMethod { .get }
    
    var queryItems: [URLQueryItem] {
        [
            .init(name: "lat", value: "\(userCoordinates.latitude)"),
            .init(name: "lon", value: "\(userCoordinates.longitude)"),
            .init(name: "exclude", value: "minutely,hourly,alerts"),
            .init(name: "units", value: "metric")
        ]
    }
    
    init(userCoordinates: UserCoordinates) {
        self.userCoordinates = userCoordinates
    }
}
