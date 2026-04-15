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
    let current_units:CurrentUnits
    let current:Current
}

struct CurrentUnits:Codable
{
    let time:String
    let interval:IntervalUnit
    let temperature_2m:String
}

struct Current:Codable
{
    let time:Date
    let interval: Int
    let temperature_2m: Double
    
}

enum IntervalUnit: String, Codable
{
enum IntervalUnit: String, Codable {
    case seconds
    case minutes
    case hours
}
}
