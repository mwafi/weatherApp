//
//  HourlyCardView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct HourlyCardView: View {

    let weather: WeatherResponse?
    @State private var selectedIndex: Int = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(hourlyItems.indices, id: \.self) { index in
                    let item = hourlyItems[index]

                    VStack(spacing: 18) {
                        Text(item.temp)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)

                        Image(item.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        Text(item.time)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 75, height: 165)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(index == selectedIndex ? Color.white.opacity(0.10) : Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(index == selectedIndex ? Color.white.opacity(0.35) : Color.clear, lineWidth: 1)
                    )
                    .onTapGesture {
                        selectedIndex = index
                    }
                }
            }
            .padding(.horizontal, 30)
        }
    }

    private var hourlyItems: [(temp: String, icon: String, time: String)] {
        guard let hourly = weather?.hourly else { return [] }

        let count = min(5, hourly.time.count)

        return (0..<count).map { index in
            (
                temp: "\(Int(hourly.temperature_2m[index].rounded()))°C",
                icon: weatherIcon(code: hourly.weather_code[index]),
                time: formatHour(hourly.time[index])
            )
        }
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
