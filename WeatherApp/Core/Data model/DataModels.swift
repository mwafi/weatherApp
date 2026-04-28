//
//  DataModels.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 15/04/2026.
//

    import Foundation
    struct WeatherResponse:Codable
    {
        let latitude: Double
        let longitude: Double
        let generationtime_ms: Double
        let utc_offset_seconds: Int
        let timezone: String
        let timezone_abbreviation: String
        let elevation:Double
        let current_units:CurrentUnits?
        let current:Current?
        let hourly_units: HourlyUnits?
        let hourly: Hourly?
        let daily_units: DailyUnits?
        let daily: Daily?
    }

    struct CurrentUnits:Codable
    {
        let time:String
        let interval:IntervalUnit
        let temperature_2m:String
    }

struct Current: Codable {
    let time: Date
    let interval: Int?
    let temperature_2m: Double
    let relative_humidity_2m: Int
    let wind_speed_10m: Double
    let weather_code: Int
}

    struct HourlyUnits: Codable {
        let time: String
        let temperature_2m: String
        let wind_speed_10m: String
        let weather_code: String
        let relative_humidity_2m: String
    }

    struct Hourly: Codable {
        let time: [Date]
        let temperature_2m: [Double]
        let wind_speed_10m: [Double]
        let weather_code: [Int]
        let relative_humidity_2m: [Int]
    }
    enum IntervalUnit:String, Codable {
        case seconds
        case minutes
        case hours
    }
struct DailyUnits: Codable {
    let time: String
    let weather_code: String
    let temperature_2m_max: String
    let temperature_2m_min: String
}

struct Daily: Codable {
    let time: [Date]
    let weather_code: [Int]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
}

struct RecentSearchItem: Codable, Identifiable {
    let id = UUID()
    let city: String
    let lat: Double
    let lon: Double
    let temperature: String
}
struct DailyForecastItem: Identifiable {
    let id = UUID()
    let date: String
    let icon: String
    let temp: String
}

struct HourlyForecastItem: Identifiable {
    let id = UUID()
    let temp: String
    let icon: String
    let time: String
}
