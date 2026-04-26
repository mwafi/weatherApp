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
    @State private var selectedCoordinate: CLLocationCoordinate2D?

    @Environment(\.dismiss) private var dismiss
    @State private var recentSearches: [RecentSearchItem] = []

    var body: some View {
        ZStack(alignment: .top) {

            MapSection(
                viewModel: viewModel,
                selectedCoordinate: $selectedCoordinate,
                cityName: $cityName
            )
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
                            cityName = city
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
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            loadRecentSearches()
        }
    }

    private func performSearch(city: String, lat: Double, lon: Double) {
        selectedCoordinate = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )

        Task {
            await viewModel.loadWeather(lat: lat, lon: lon)

            let currentTemp = "\(Int(viewModel.weather?.current?.temperature_2m.rounded() ?? 0))°"

            await MainActor.run {
                recentSearches.removeAll {
                    $0.city.lowercased() == city.lowercased()
                }

                recentSearches.insert(
                    RecentSearchItem(
                        city: city,
                        lat: lat,
                        lon: lon,
                        temperature: currentTemp
                    ),
                    at: 0
                )

                if recentSearches.count > 5 {
                    recentSearches = Array(recentSearches.prefix(5))
                }

                saveRecentSearches()

                withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                    showSearchCard = false
                }
            }
        }
    }

    private func searchByName() {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        CLGeocoder().geocodeAddressString(trimmed) { placemarks, error in
            guard error == nil,
                  let placemark = placemarks?.first,
                  let coordinate = placemark.location?.coordinate else {
                return
            }

            let resultName =
                placemark.locality ??
                placemark.administrativeArea ??
                placemark.country ??
                trimmed

            DispatchQueue.main.async {
                cityName = resultName

                performSearch(
                    city: resultName,
                    lat: coordinate.latitude,
                    lon: coordinate.longitude
                )
            }
        }
    }

    private func saveRecentSearches() {
        if let data = try? JSONEncoder().encode(recentSearches) {
            UserDefaults.standard.set(data, forKey: "recentSearches")
        }
    }

    private func loadRecentSearches() {
        guard let data = UserDefaults.standard.data(forKey: "recentSearches"),
              let saved = try? JSONDecoder().decode([RecentSearchItem].self, from: data)
        else { return }

        recentSearches = saved
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
