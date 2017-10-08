//
//  WeatherListViewModel.swift
//  WeatherAPP
//
//  Created by ruixue on 8/10/17.
//  Copyright © 2017 rui. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    private let client = WeatherClient()
    private let cityList = [("Sydney", 2147714), ("Melbourn", 4163971), ("Brisbane", 2174003)]
    private var cityWeatherList: [Int: WeatherDetails] = [:]
    
    var numberOfCities: Int {
        return cityList.count
    }
    
    func weatherDetails(forCity cityID: Int) -> WeatherDetails? {
        return cityWeatherList[cityID]
    }
    
    func city(at index: Int) -> (String, Int)? {
        return cityList[safe: index]
    }
    
    func temperature(forCity cityID: Int) -> Double? {
        return cityWeatherList[cityID]?.main.temperature
    }
    
    func fetchWeather(for cityID: Int, completionHandler: @escaping (WeatherError?) -> Void) {
        client.fetchWeatherDataWith(cityID: cityID) { [weak self] result in
            guard let sself = self else { return }
            switch result {
            case let .success(weatherDetails):
                sself.cityWeatherList[cityID] = weatherDetails
                completionHandler(nil)
            case let .failure(error):
                completionHandler(error)
            }
        }
    }
}
