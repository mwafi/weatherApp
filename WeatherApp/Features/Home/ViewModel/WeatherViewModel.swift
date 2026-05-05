//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import Foundation
internal import Combine



@MainActor
final class WeatherViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var state: WeatherUIState = .idle

    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func loadWeather(lat: Double, lon: Double) async {
        state = .loading

        do {
            let result = try await weatherService.fetchWeather(
                lat: lat,
                lon: lon
            )

            self.weather = result

            guard let uiModel = WeatherUIMapper.makeHomeUIModel(from: result) else {
                state = .failure("Weather data is not available.")
                return
            }

            state = .success(uiModel)

        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
