//
//  File.swift
//  WeatherAppTests
//
//  Created by Mohammed Hassanien on 05/05/2026.
//
import Foundation
@testable import WeatherApp

final class MockWeatherService: WeatherServiceProtocol {

    let result: Result<WeatherResponse, Error>

    private(set) var receivedLat: Double?
    private(set) var receivedLon: Double?

    init(result: Result<WeatherResponse, Error>) {
        self.result = result
    }

    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        receivedLat = lat
        receivedLon = lon

        switch result {
        case .success(let weatherResponse):
            return weatherResponse

        case .failure(let error):
            throw error
        }
    }
}
