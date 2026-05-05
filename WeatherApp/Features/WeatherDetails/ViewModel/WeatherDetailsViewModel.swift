//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 26/04/2026.
//

import Foundation
internal import Combine

@MainActor
final class WeatherDetailsViewModel: ObservableObject {

    @Published var currentTemp = "--°"
    @Published var formattedDate = "--"
    @Published var hourlyItems: [HourlyForecastItem] = []
    @Published var dailyItems: [DailyForecastItem] = []

    func configure(with weather: WeatherResponse?) {
        guard let weather else {
            reset()
            return
        }

        currentTemp = formatTemperature(weather.current?.temperature_2m)
        formattedDate = WeatherDateFormatter.shortDate(weather.current?.time)
        hourlyItems = WeatherUIMapper.makeHourlyItems(from: weather)
        dailyItems = WeatherUIMapper.makeDailyItems(from: weather)
    }

    private func reset() {
        currentTemp = "--°"
        formattedDate = "--"
        hourlyItems = []
        dailyItems = []
    }

    private func formatTemperature(_ temp: Double?) -> String {
        guard let temp else { return "--°" }
        return "\(Int(temp.rounded()))°"
    }
}
