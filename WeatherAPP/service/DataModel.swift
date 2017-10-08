//
//  DataModel.swift
//  WeatherAPP
//
//  Created by ruixue on 7/10/17.
//  Copyright © 2017 rui. All rights reserved.
//

import Foundation

struct Main {
    let temperature: Double
    let pressure: Double
    let humidity: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    init?(dictionary: [String: Any]) {
        guard let temperature = dictionary["temp"] as? Double,
            let pressure = dictionary["pressure"] as? Double,
            let humidity = dictionary["humidity"] as? Double,
            let temperatureMin = dictionary["temp_min"] as? Double,
            let temperatureMax = dictionary["temp_max"] as? Double else { return nil }
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
    }
}

struct Weather {
    let id: Int
    let summary: String
    let description: String
    let icon: String
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let summary = dictionary["main"] as? String,
            let description = dictionary["description"] as? String,
            let icon = dictionary["icon"] as? String else { return nil }
        self.id = id
        self.summary = summary
        self.description = description
        self.icon = icon
    }
}

struct Wind {
    let speed: Double
    let deg: Int
    
    init?(dictionary: [String: Any]) {
        guard let speed = dictionary["speed"] as? Double,
            let deg = dictionary["deg"] as? Int else { return nil }
        self.speed = speed
        self.deg = deg
    }
}

struct WeatherDetails {
    let id: Int
    let visibility: Int
    let city: String
    let weather: Weather
    let main: Main
    let wind: Wind
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let visibility = dictionary["visibility"] as? Int,
            let city = dictionary["name"] as? String,
            let weatherArrayData = dictionary["weather"] as? [[String: Any]],
            let weatherData = weatherArrayData.first,
            let weather = Weather(dictionary: weatherData),
            let mainData = dictionary["main"] as? [String: Any],
            let main = Main(dictionary: mainData),
            let windData = dictionary["wind"] as? [String: Any],
            let wind = Wind(dictionary: windData) else { return nil }
        self.id = id
        self.visibility = visibility
        self.city = city
        self.weather = weather
        self.main = main
        self.wind = wind
    }
}
