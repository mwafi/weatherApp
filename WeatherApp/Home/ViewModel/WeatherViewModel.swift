//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import Foundation
internal import Combine
import SwiftUI

@MainActor
final class WeatherViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var uiModel: WeatherUIModel?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService = WeatherService()

    func loadWeather(lat: Double, lon: Double) async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await weatherService.fetchWeather(lat: lat, lon: lon)
            self.weather = result

            guard let current = result.current else {
                errorMessage = "Weather data is not available."
                isLoading = false
                return
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMMM"
            formatter.locale = Locale(identifier: "en_US")

            let condition = mapWeatherCode(current.weather_code)

            self.uiModel = WeatherUIModel(
                date: formatter.string(from: current.time),
                temperature: "\(Int(current.temperature_2m.rounded()))°",
                condition: condition.text,
                wind: "\(Int(current.wind_speed_10m.rounded())) km/h",
                humidity: "\(current.relative_humidity_2m) %",
                imageName: condition.image
            )

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func mapWeatherCode(_ code: Int) -> (text: String, image: String) {
        switch code {
        case 0:
            return ("Sunny", "Suny 1")
        case 1...3:
            return ("Cloudy", "Cloudy")
        case 45, 48:
            return ("Fog", "Cloudy")
        case 51...67, 80...82:
            return ("rain", "rain")
        case 71...77:
            return ("Snowy", "Cloudy")
        case 95...99:
            return ("Storm", "rain")
        default:
            return ("Cloudy", "Cloudy")
        }
    }
}
