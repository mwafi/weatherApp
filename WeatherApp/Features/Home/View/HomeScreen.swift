//
//  HomeScreen.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//
import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityName: String = "Jerusalem"
    @State private var showNotifications = false
    @State private var didLoadInitialWeather = false

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

                    if let ui = viewModel.uiModel {

                        WeatherIllustrationView(conditionName: ui.imageName)

                        CurrentWeatherCardView(
                            dateText: ui.date,
                            temperatureText: ui.temperature,
                            conditionText: ui.condition,
                            windText: ui.wind,
                            humidityText: ui.humidity
                        )

                    } else if viewModel.isLoading {

                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.3)

                    } else if let error = viewModel.errorMessage {

                        Text(error)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()

                    ForecastReportButtonView(viewModel: viewModel)

               
                }

                if showNotifications {
                    NotificationsOverlayView(isPresented: $showNotifications)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .zIndex(1000)
                }
            }
            .task {
                guard !didLoadInitialWeather else { return }
                didLoadInitialWeather = true
                await viewModel.loadWeather(lat: 31.7683, lon: 35.2137)            }
        }
    }
}
#Preview {
    HomeScreen()
}
