//
//  File.swift
//  WeatherAppTests
//
//  Created by Mohammed Hassanien on 05/05/2026.
//
import Foundation
@testable import WeatherApp

enum WeatherTestFixtures {

    static let latitude = 52.52
    static let longitude = 13.4

    static let temperature = 6.1
    static let windSpeed = 12.3
    static let weatherCode = 2
    static let humidity = 47

    static let maxTemperature = 12.0
    static let minTemperature = 4.0

    static let currentDate = makeDate(
        "2026-04-28T02:00",
        format: "yyyy-MM-dd'T'HH:mm"
    )

    static let dailyDate = makeDate(
        "2026-04-28",
        format: "yyyy-MM-dd"
    )

    static var weatherResponse: WeatherResponse {
        WeatherResponse(
            latitude: latitude,
            longitude: longitude,
            generationtime_ms: 0.05078315734863281,
            utc_offset_seconds: 0,
            timezone: "GMT",
            timezone_abbreviation: "GMT",
            elevation: 38,
            current_units: nil,
            current: Current(
                time: currentDate,
                interval: nil,
                temperature_2m: temperature,
                relative_humidity_2m: humidity,
                wind_speed_10m: windSpeed,
                weather_code: weatherCode
            ),
            hourly_units: nil,
            hourly: Hourly(
                time: [currentDate],
                temperature_2m: [temperature],
                wind_speed_10m: [windSpeed],
                weather_code: [weatherCode],
                relative_humidity_2m: [humidity]
            ),
            daily_units: nil,
            daily: Daily(
                time: [dailyDate],
                weather_code: [weatherCode],
                temperature_2m_max: [maxTemperature],
                temperature_2m_min: [minTemperature]
            )
        )
    }

    static let validWeatherJSON = """
    {
      "latitude": \(latitude),
      "longitude": \(longitude),
      "generationtime_ms": 0.05078315734863281,
      "utc_offset_seconds": 0,
      "timezone": "GMT",
      "timezone_abbreviation": "GMT",
      "elevation": 38,
      "current": {
        "time": "2026-04-28T02:00",
        "temperature_2m": \(temperature),
        "wind_speed_10m": \(windSpeed),
        "weather_code": \(weatherCode),
        "relative_humidity_2m": \(humidity)
      },
      "hourly": {
        "time": ["2026-04-28T02:00"],
        "temperature_2m": [\(temperature)],
        "wind_speed_10m": [\(windSpeed)],
        "weather_code": [\(weatherCode)],
        "relative_humidity_2m": [\(humidity)]
      },
      "daily": {
        "time": ["2026-04-28"],
        "weather_code": [\(weatherCode)],
        "temperature_2m_max": [\(maxTemperature)],
        "temperature_2m_min": [\(minTemperature)]
      }
    }
    """.data(using: .utf8)!

    static let invalidWeatherJSON = """
    {
      "current": "invalid"
    }
    """.data(using: .utf8)!

    static func successHTTPResponse() -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "https://api.open-meteo.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
    }

    static func serverErrorHTTPResponse() -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "https://api.open-meteo.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )!
    }

    private static func makeDate(_ value: String, format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = formatter.date(from: value) else {
            fatalError("Invalid test date: \(value)")
        }

        return date
    }
}
