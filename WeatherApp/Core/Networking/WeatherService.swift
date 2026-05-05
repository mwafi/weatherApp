//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 15/04/2026.
//

import Foundation

final class WeatherService: WeatherServiceProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let url = try makeWeatherURL(lat: lat, lon: lon)
        let data = try await performRequest(from: url)
        return try decodeWeather(from: data)
    }
}

private extension WeatherService {

    func makeWeatherURL(lat: Double, lon: Double) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.open-meteo.com"
        components.path = "/v1/forecast"

        components.queryItems = [
            URLQueryItem(name: "latitude", value: String(lat)),
            URLQueryItem(name: "longitude", value: String(lon)),
            URLQueryItem(
                name: "current",
                value: "temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code"
            ),
            URLQueryItem(
                name: "hourly",
                value: "temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code"
            ),
            URLQueryItem(
                    name: "daily",
                    value: "weather_code,temperature_2m_max,temperature_2m_min"
                ),
            URLQueryItem(name: "timezone", value: "auto")
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        return url
    }   
    func performRequest(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)

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

        let dailyFormatter = DateFormatter()
        dailyFormatter.dateFormat = "yyyy-MM-dd"
        dailyFormatter.locale = Locale(identifier: "en_US_POSIX")

        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = formatter.date(from: dateString) {
                return date
            }

            if let date = dailyFormatter.date(from: dateString) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date: \(dateString)"
            )
        }

        return try decoder.decode(WeatherResponse.self, from: data)
    }
}
