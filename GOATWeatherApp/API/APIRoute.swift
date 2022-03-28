//
//  APIRoute.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

public protocol APIRoute {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    // case post, put etc if needed
}
