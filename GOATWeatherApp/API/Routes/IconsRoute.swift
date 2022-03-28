//
//  IconsRoute.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

struct IconsRoute: APIRoute {
    private let iconName: String
    var path: String { "/img/wn/" }
    
    var method: HTTPMethod  { .get }
    
    var queryItems: [URLQueryItem] {
        [
            .init(name: "", value: "\(iconName)@2x.png"),
        ]
    }
    
    init(iconName: String) {
        self.iconName = iconName
    }
}

