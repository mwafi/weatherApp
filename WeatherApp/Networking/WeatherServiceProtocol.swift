//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 15/04/2026.
//

import Foundation
protocol WeatherServiceProtocol {
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse
}
