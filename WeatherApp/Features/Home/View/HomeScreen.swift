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
    @State private var showAppLoading = true

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

                    switch viewModel.state {

                    case .idle:
                        loadingStateView()

                    case .loading:
                        loadingStateView()

                    case .success(let ui):
                        successStateView(ui: ui)

                    case .failure(let message):
                        errorStateView(message: message)
                    }

                    Spacer()

                    if case .success = viewModel.state {
                        ForecastReportButtonView(viewModel: viewModel)
                    }
                }

                if showNotifications {
                    NotificationsOverlayView(isPresented: $showNotifications)
                        .zIndex(1000)
                }

                if showAppLoading {
                    AppLoadingView()
                        .zIndex(2000)
                }
            }
            .task {
                guard !didLoadInitialWeather else { return }
                didLoadInitialWeather = true

                async let weatherTask: Void = viewModel.loadWeather(
                    lat: 31.7683,
                    lon: 35.2137
                )

                try? await Task.sleep(nanoseconds: 2_000_000_000)

                withAnimation {
                    showAppLoading = false
                }

                await weatherTask
            }
        }
    }
    
    private func loadingStateView() -> some View {
        VStack(spacing: 20) {
            WeatherIllustrationView(conditionName: "placeholder")

            CurrentWeatherCardView(
                dateText: "Today, 12 September",
                temperatureText: "29°",
                conditionText: "Cloudy",
                windText: "10 km/h",
                humidityText: "54 %",
                isLoading: false
            )
        }
        .redacted(reason: .placeholder)
    }

    private func successStateView(ui: WeatherUIModel) -> some View {
        VStack(spacing: 20) {
            WeatherIllustrationView(conditionName: ui.imageName)

            CurrentWeatherCardView(
                dateText: ui.date,
                temperatureText: ui.temperature,
                conditionText: ui.condition,
                windText: ui.wind,
                humidityText: ui.humidity,
                isLoading: false
            )
        }
    }

    private func errorStateView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 42))
                .foregroundColor(.white)

            Text(message)
                .font(.custom("Overpass-Bold", size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Button {
                Task {
                    await viewModel.loadWeather(
                        lat: 31.7683,
                        lon: 35.2137
                    )
                }
            } label: {
                Text("Try again")
                    .font(.custom("Overpass-Bold", size: 16))
                    .foregroundColor(Color(red: 0.29, green: 0.33, blue: 0.50))
                    .padding(.horizontal, 24)
                    .frame(height: 48)
                    .background(Color.white.opacity(0.96))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    HomeScreen()
}
