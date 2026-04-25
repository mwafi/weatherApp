//
//  SearchView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI
import MapKit
import CoreLocation

struct SearchView: View {
    @Binding var cityName: String
    @ObservedObject var viewModel: WeatherViewModel

    @State private var searchText = ""
    @State private var showSearchCard = false
    @Environment(\.dismiss) private var dismiss

    @State private var recentSearches: [(city: String, lat: Double, lon: Double, temperature: String)] = [
        (city: "Surabaya", lat: -7.2575, lon: 112.7521, temperature: "34°")
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.94, green: 0.96, blue: 0.99)
                .ignoresSafeArea()

            MapSection(viewModel: viewModel)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                if !showSearchCard {
                    SearchBarComponent(
                        text: $searchText,
                        onTap: {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                                showSearchCard = true
                            }
                        },
                        onBack: {
                            dismiss()
                        },
                        isExpanded: false,
                        onSubmit: {
                            searchByName()
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 70)
                }

                Spacer()
            }

            if showSearchCard {
                Color.black.opacity(0.10)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                            showSearchCard = false
                        }
                    }

                VStack(spacing: 0) {
                    SearchTopCard(
                        searchText: $searchText,
                        recentSearches: recentSearches,
                        onSelectCity: { city, lat, lon in
                            self.cityName = city
                            searchText = city
                            performSearch(city: city, lat: lat, lon: lon)
                        },
                        onSearchSubmit: {
                            searchByName()
                        },
                        onClose: {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                                showSearchCard = false
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .padding(.top, 18)

                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private func performSearch(city: String, lat: Double, lon: Double) {
        Task {
            await viewModel.loadWeather(lat: lat, lon: lon)

            let currentTemp = "\(Int(viewModel.weather?.current.temperature_2m ?? 0))°"

            recentSearches.removeAll { $0.city.lowercased() == city.lowercased() }

            recentSearches.insert(
                (city: city, lat: lat, lon: lon, temperature: currentTemp),
                at: 0
            )

            if recentSearches.count > 5 {
                recentSearches = Array(recentSearches.prefix(5))
            }

            withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                showSearchCard = false
            }
        }
    }

    private func searchByName() {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(trimmed) { placemarks, error in
            guard error == nil,
                  let placemark = placemarks?.first,
                  let coordinate = placemark.location?.coordinate else {
                return
            }

            let cityNameResult = placemark.locality ?? placemark.country ?? trimmed
            self.cityName = cityNameResult
            performSearch(city: cityNameResult, lat: coordinate.latitude, lon: coordinate.longitude)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(
            cityName: .constant("Semarang"),
            viewModel: WeatherViewModel()
        )
    }
}
