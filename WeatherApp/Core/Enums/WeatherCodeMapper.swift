//
//  WeatherCodeMapper.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 03/05/2026.
//

import Foundation

enum WeatherCodeMapper {

    static func condition(for code: Int) -> WeatherCondition {
        switch code {
        case 0:
            return WeatherCondition(
                text: "Sunny",
                homeImageName: "Suny 1",
                detailsImageName: "Suny 1"
            )

        case 1...3:
            return WeatherCondition(
                text: "Cloudy",
                homeImageName: "Cloudy",
                detailsImageName: "sun cloudy"
            )

        case 45, 48:
            return WeatherCondition(
                text: "Fog",
                homeImageName: "Cloudy",
                detailsImageName: "cloud"
            )

        case 51...67, 80...82:
            return WeatherCondition(
                text: "Rain",
                homeImageName: "rain",
                detailsImageName: "rain"
            )

        case 71...77:
            return WeatherCondition(
                text: "Snowy",
                homeImageName: "Cloudy",
                detailsImageName: "cloud"
            )

        case 95...99:
            return WeatherCondition(
                text: "Storm",
                homeImageName: "rain",
                detailsImageName: "thunder"
            )

        default:
            return WeatherCondition(
                text: "Cloudy",
                homeImageName: "Cloudy",
                detailsImageName: "sun cloudy"
            )
        }
    }
}
