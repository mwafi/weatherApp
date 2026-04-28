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
        guard let weather else { return }

        currentTemp = formatTemperature(weather.current?.temperature_2m)
        formattedDate = formatDate(weather.current?.time)
        hourlyItems = makeHourlyItems(from: weather)
        dailyItems = makeDailyItems(from: weather)
    }

    private func makeHourlyItems(from weather: WeatherResponse) -> [HourlyForecastItem] {
        guard let hourly = weather.hourly else { return [] }

        let count = min(
            5,
            hourly.time.count,
            hourly.temperature_2m.count,
            hourly.weather_code.count
        )

        return (0..<count).map { index in
            HourlyForecastItem(
                temp: "\(Int(hourly.temperature_2m[index].rounded()))°C",
                icon: weatherIcon(code: hourly.weather_code[index]),
                time: formatHour(hourly.time[index])
            )
        }
    }

    private func makeDailyItems(from weather: WeatherResponse) -> [DailyForecastItem] {
        guard let daily = weather.daily else { return [] }

        let count = min(
            5,
            daily.time.count,
            daily.weather_code.count,
            daily.temperature_2m_max.count
        )

        return (0..<count).map { index in
            DailyForecastItem(
                date: formatDate(daily.time[index]),
                icon: weatherIcon(code: daily.weather_code[index]),
                temp: "\(Int(daily.temperature_2m_max[index].rounded()))°"
            )
        }
    }

    private func formatTemperature(_ temp: Double?) -> String {
        guard let temp else { return "--°" }
        return "\(Int(temp.rounded()))°"
    }

    private func formatDate(_ date: Date?) -> String {
        guard let date else { return "--" }

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, d"
        return formatter.string(from: date)
    }

    private func formatHour(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private func weatherIcon(code: Int) -> String {
        switch code {
        case 0:
            return "Suny 1"
        case 1...3:
            return "sun cloudy"
        case 45, 48:
            return "cloud"
        case 51, 53, 55, 61, 63, 65, 80, 81, 82:
            return "rain"
        case 95, 96, 99:
            return "thunder"
        default:
            return "sun cloudy"
        }
    }
}
