//
//  WeatherDateFormatter.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 03/05/2026.
//
import Foundation

enum WeatherDateFormatter {

    static func homeDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }

    static func shortDate(_ date: Date?) -> String {
        guard let date else { return "--" }

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, d"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }

    static func hour(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}
