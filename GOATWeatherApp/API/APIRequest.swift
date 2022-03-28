//
//  APIRequest.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

struct APIRequest {
    
    let apiInfo = APIInfoLoader.load()
    
    // MARK: - Data
    func createAPIRequest(for route: APIRoute) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = apiInfo.hostURL
        urlComponents.path = route.path
        urlComponents.queryItems = route.queryItems
        urlComponents.queryItems?.append(.init(name: "appId", value: apiInfo.apiKey))
        
        guard let url = urlComponents.url else { return nil }
        print("DEBUG: Request URL: \(url)")
        return URLRequest(url: url)
    }
    
    // MARK: - Icons
    func createAPIRequest(forIcon route: APIRoute) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = apiInfo.iconHostURL
        urlComponents.path = route.path
        urlComponents.queryItems = route.queryItems
        urlComponents.queryItems?.append(.init(name: "appId", value: apiInfo.apiKey))
        
        guard let url = urlComponents.url else { return nil }
        print("DEBUG: Request URL: \(url)")
        return URLRequest(url: url)
    }
    
}
