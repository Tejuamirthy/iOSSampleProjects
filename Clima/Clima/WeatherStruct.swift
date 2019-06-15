//
//  File.swift
//  Clima
//
//  Created by Amirthy Tejeshwar on 13/06/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct Coordinates: Codable{
    let lon: Double?
    let lat: Double?
}
struct Wind: Codable{
    let speed: Double?
    let deg: Double?
}

struct Weather: Codable{
    let id: Int?
}
struct Main: Codable{
    let temp: Double?
}

struct WeatherStruct: Codable {
    
    let coord: Coordinates?
    let base: String?
    let visibility: Int?
    let name: String?
    let cod: Int?
    let main: Main?
    let timezon: Int?
    let wind: Wind?
    let weather: [Weather]?
    
}
//    "coord":{"lon":37.62,"lat":55.76},
//    "weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],
//    "base":"stations",
//    "main":{"temp":286.28,"pressure":1028,"humidity":46,"temp_min":285.15,"temp_max":287.15},
//    "visibility":10000,
//    "wind":{"speed":6,"deg":80},
//    "clouds":{"all":0},
//    "dt":1560408402,
//    "sys":{"type":1,"id":9027,"message":0.0059,"country":"RU","sunrise":1560386709,"sunset":1560449638},
//    "timezon:10800,
//    "id":524925,
//    "name":"Moskovskaya Oblast’",
//    "cod":200
//
//    }
