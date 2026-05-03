//
//  WeatherUIMapper.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 03/05/2026.
//

import Foundation

enum WeatherUIMapper {

    static func makeHomeUIModel(from response: WeatherResponse) -> WeatherUIModel? {
        guard let current = response.current else {
            return nil
        }

        let condition = WeatherCodeMapper.condition(for: current.weather_code)

        return WeatherUIModel(
            date: WeatherDateFormatter.homeDate(current.time),
            temperature: "\(Int(current.temperature_2m.rounded()))°",
            condition: condition.text,
            wind: "\(Int(current.wind_speed_10m.rounded())) km/h",
            humidity: "\(current.relative_humidity_2m) %",
            imageName: condition.homeImageName
        )
    }

    static func makeHourlyItems(from weather: WeatherResponse) -> [HourlyForecastItem] {
        guard let hourly = weather.hourly else { return [] }

        let count = min(
            5,
            hourly.time.count,
            hourly.temperature_2m.count,
            hourly.weather_code.count
        )

        return (0..<count).map { index in
            let condition = WeatherCodeMapper.condition(
                for: hourly.weather_code[index]
            )

            return HourlyForecastItem(
                temp: "\(Int(hourly.temperature_2m[index].rounded()))°C",
                icon: condition.detailsImageName,
                time: WeatherDateFormatter.hour(hourly.time[index])
            )
        }
    }

    static func makeDailyItems(from weather: WeatherResponse) -> [DailyForecastItem] {
        guard let daily = weather.daily else { return [] }

        let count = min(
            5,
            daily.time.count,
            daily.weather_code.count,
            daily.temperature_2m_max.count
        )

        return (0..<count).map { index in
            let condition = WeatherCodeMapper.condition(
                for: daily.weather_code[index]
            )

            return DailyForecastItem(
                date: WeatherDateFormatter.shortDate(daily.time[index]),
                icon: condition.detailsImageName,
                temp: "\(Int(daily.temperature_2m_max[index].rounded()))°"
            )
        }
    }
}
