//
//  APIClient.swift
//  WeatherAPP
//
//  Created by ruixue on 7/10/17.
//  Copyright © 2017 rui. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case network(Error)
    case malformedEndpoint
    case deserializing
    case unknown
}

enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

struct WeatherClient {
    private let endpoint = "http://api.openweathermap.org/data/2.5/weather"
    private let key = "8d8cd50ff23cafdeb7f7dd197a4c3987"
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchWeatherDataWith(cityID: Int,
                              completionHandler: @escaping (Result<WeatherDetails, WeatherError>) -> Void) {
        guard let request = urlRequestWith(cityID: cityID) else {
            completionHandler(.failure(.malformedEndpoint))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error { return completionHandler(.failure(.network(error))) }
            guard let data = data,
                let jsonData = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any],
                let weatherData = WeatherDetails(dictionary: jsonData) else {
                    return completionHandler(.failure(.deserializing))
            }
            completionHandler(.success(weatherData))
            }.resume()
    }
    
    private func urlRequestWith(cityID: Int) -> URLRequest? {
        guard let url = URL(string: endpoint),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = ["id": "\(cityID)", "units": "metric", "APPID": key].map { URLQueryItem(name: $0.0, value: $0.1) }
        guard let urlCompleted = urlComponents.url else { return nil }
        return URLRequest(url: urlCompleted)
    }
}
