//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 15/04/2026.
//

import Foundation

final class WeatherService: WeatherServiceProtocol {

    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let url = try makeWeatherURL(lat: lat, lon: lon)
        let data = try await performRequest(from: url)
        return try decodeWeather(from: data)
    }
}

// MARK: - Private Helpers
private extension WeatherService {

    func makeWeatherURL(lat: Double, lon: Double) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.open-meteo.com"
        components.path = "/v1/forecast"
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(lat)"),
            URLQueryItem(name: "longitude", value: "\(lon)"),
            URLQueryItem(name: "current", value: "temperature_2m"),
            URLQueryItem(name: "timezone", value: "auto")
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        return url
    }

    func performRequest(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return data
    }

    func decodeWeather(from data: Data) throws -> WeatherResponse {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)

        return try decoder.decode(WeatherResponse.self, from: data)
    }
}
