//
//  APIInfoLoader.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

struct APIInfo: Codable {
    var apiKey: String
    var hostURL: String
    var iconHostURL: String
}

class APIInfoLoader {
    static private var plistURL: URL? {
        guard let path = Bundle.main.path(forResource: "API", ofType: "plist") else { return nil }
        return URL(fileURLWithPath: path)
    }
    
    static func load() -> APIInfo {
        let decoder = PropertyListDecoder()
        guard let url = plistURL,
              let data = try? Data(contentsOf: url),
              let preferences = try? decoder.decode(APIInfo.self, from: data) else {
                  return .init(apiKey: "", hostURL: "", iconHostURL: "")
              }
        
        return preferences
    }

}
