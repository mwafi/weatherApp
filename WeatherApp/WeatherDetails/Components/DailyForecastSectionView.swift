//
//  DailyForecastSectionView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct DailyForecastSectionView: View {

    let weather: WeatherResponse?

    var body: some View {
        VStack(spacing: 10) {

            HStack {
                Text("Next Forecast")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "calendar")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)

            VStack(spacing: 15) {
                ForEach(dailyItems) { item in
                    DailyRowView(
                        date: item.date,
                        icon: item.icon,
                        temp: item.temp
                    )
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 32)

            Spacer()

            HStack(spacing: 10) {
                Image(systemName: "sun.max")
                    .font(.system(size: 20))
                    .foregroundColor(.white)

                Text("AccuWeather")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.bottom, 24)
        }
    }

    private var dailyItems: [DailyForecastItem] {
        guard let daily = weather?.daily else { return [] }

        let count = min(5, daily.time.count)

        return (0..<count).map { index in
            DailyForecastItem(
                date: formatDate(daily.time[index]),
                icon: weatherIcon(code: daily.weather_code[index]),
                temp: "\(Int(daily.temperature_2m_max[index].rounded()))°"
            )
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, d"
        return formatter.string(from: date)
    }

    private func weatherIcon(code: Int) -> String {
        switch code {
        case 0:
            return "Suny"
        case 1, 2, 3:
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

