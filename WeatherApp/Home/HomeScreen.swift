//
//  HomeScreen.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//
import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityName: String = "Semarang"
    @State private var showNotifications = false
    @State private var didLoadInitialWeather = false

    private var formattedDate: String {
        guard let date = viewModel.weather?.current.time else { return "Today" }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: date)
    }

    private var temperatureText: String {
        guard let temp = viewModel.weather?.current.temperature_2m else { return "--°" }
        return "\(Int(temp.rounded()))°"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                HomeBackgroundView()

                VStack(spacing: 20) {
                    HomeHeaderView(
                        cityName: $cityName,
                        showNotifications: $showNotifications,
                        viewModel: viewModel
                    )

                    WeatherIllustrationView(conditionName: "Cloudy")

                    CurrentWeatherCardView(
                        dateText: formattedDate,
                        temperatureText: temperatureText,
                        conditionText: "Cloudy",
                        windText: "10 km/h",
                        humidityText: "54 %"
                    )

                    ForecastReportButtonView(viewModel: viewModel)

                    Spacer()
                }

                // ✅ ده اللي يرجع الشكل القديم
                if showNotifications {
                    NotificationsOverlayView(isPresented: $showNotifications)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .zIndex(1000)
                }
            }
            .task {
                guard !didLoadInitialWeather else { return }
                didLoadInitialWeather = true
                await viewModel.loadWeather()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
