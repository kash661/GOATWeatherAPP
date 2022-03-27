//
//  APIError.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

// simple error enum, this could be customized further 
enum APIError: Error {
    case invalidData
    case offline
    case unexpected(Error?)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Something went wrong"
        case .offline:
            return "Looks like your are offline"
        case .unexpected(let error):
            return "Unexpected Error: \(String(describing: error?.localizedDescription))"
     
        }
    }
}
