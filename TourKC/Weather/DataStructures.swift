//
//  DataStructures.swift
//  TourKC
//
//  Created by Nathan Bronson on 6/4/22.
//

import Foundation

struct WResult: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: sMain
    let visibility: Double
    let wind: Wind
    let clouds: Clouds
    let dt: Double
    let sys: Sys
    let timezone: Double
    let id: Double
    let name: String
    let cod: Double
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Sys: Codable {
    let type: Double
    let id: Double
    let country: String
    let sunrise: Double
    let sunset: Double
}

struct Clouds: Codable {
    let all: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct sMain: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Weather: Codable {
    let id: Double
    let main: String
    let description: String
    let icon: String
}
