//
//  APIClient.swift
//  GOATWeatherApp
//
//  Created by Akash Desai on 2022-03-27.
//

import Foundation

public struct APIClient { //would have protocol to implement functions
    private let urlSession: URLSession
    private let apiRequest: APIRequest
    
    init(
        urlSession: URLSession = URLSession.shared,
        apiRequest: APIRequest = APIRequest())
    {
        self.urlSession = urlSession
        self.apiRequest = apiRequest
    }
    
    // MARK: - DATA Request
    func request(_ route: APIRoute, queue: DispatchQueue?, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let request = self.apiRequest.createAPIRequest(for: route) else {
            queue?.async {
                completion(.failure(APIError.unexpected(nil)))
            }
            return
        }
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error { // i would also check the URLError codes here to determine the other error cases
                completion(.failure(APIError.unexpected(error)))
                return
            }
            
            guard let data = data else  {
                completion(.failure(APIError.unexpected(error)))
                return
            }
            queue?.async {
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - ICON Request
    func requestIcons(_ route: APIRoute, queue: DispatchQueue?, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let request = self.apiRequest.createAPIRequest(forIcon: route) else {
            queue?.async {
                completion(.failure(APIError.unexpected(nil)))
            }
            return
        }
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error { // i would also check the URLError codes here to determine the other error cases
                completion(.failure(APIError.unexpected(error)))
                return
            }
            
            guard let data = data else  {
                completion(.failure(APIError.unexpected(error)))
                return
            }
            queue?.async {
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
}
