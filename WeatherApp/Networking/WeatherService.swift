//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 15/04/2026.
//

import Foundation
final class WeatherService: WeatherServiceProtocol {

    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current=temperature_2m&timezone=auto"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return try decoder.decode(WeatherResponse.self, from: data)
    }
}
