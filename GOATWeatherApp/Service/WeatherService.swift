//
//  WeatherService.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation
import UIKit

struct WeatherService {
    let apiClient: APIClient
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getWeather(using userCoordinates: UserCoordinates, completion: @escaping (Result<WeatherResponse, APIError>) -> Void) {
        let route = CurrentLocationRoute(userCoordinates: userCoordinates)
        apiClient.request(route, queue: .main) { result in
            switch result {
                
            case .success(let data):
                do {
                    let apiResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(APIError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImages(using imageUrls: [String], completion: @escaping (Result<[UIImage], APIError>) -> Void) {
        var images: [UIImage] = []
        let group = DispatchGroup()
        
        for imageUrl in imageUrls {
            guard let url = URL(string: imageUrl) else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            group.enter()
            URLSession.shared.dataTask(with: url) { data, response, error in
                group.leave()
                if let error = error {
                    completion(.failure(APIError.unexpected(error)))
                }
                
                if let imageData = data, let image = UIImage(data: imageData) {
                    images.append(image)
                }
            }.resume()
            
            group.notify(queue: .main) {
                completion(.success(images))
            }
        }
    }
}
