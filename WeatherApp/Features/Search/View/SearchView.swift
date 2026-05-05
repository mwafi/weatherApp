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

    @StateObject private var searchViewModel = SearchViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var oldCityName: String = ""

    var body: some View {
        ZStack(alignment: .top) {

            MapSection(
                viewModel: viewModel,
                selectedCoordinate: $searchViewModel.selectedCoordinate,
                cityName: $cityName
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                if !searchViewModel.showSearchCard {
                    SearchBarComponent(
                        text: $searchViewModel.searchText,
                        onTap: {
                            searchViewModel.openSearchCard()
                        },
                        onBack: {
                            cityName = oldCityName
                            searchViewModel.searchText = oldCityName
                            dismiss()
                        },
                        isExpanded: false,
                        onSubmit: {
                            submitSearch()
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }

                Spacer()

                if !searchViewModel.showSearchCard {
                    VStack {
                        Spacer()

                        ConfirmLocation(onBack: {
                            dismiss()
                        })
                        .padding(.bottom, 34)
                    }
                }
            }

            if searchViewModel.showSearchCard {
                Color.black.opacity(0.10)
                    .ignoresSafeArea()
                    .onTapGesture {
                        searchViewModel.closeSearchCard()
                    }

                VStack(spacing: 0) {
                    SearchTopCard(
                        searchText: $searchViewModel.searchText,
                        recentSearches: searchViewModel.recentSearches,
                        onSelectCity: { city, lat, lon in
                            selectCity(city: city, lat: lat, lon: lon)
                        },
                        onSearchSubmit: {
                            submitSearch()
                        },
                        onClose: {
                            searchViewModel.closeSearchCard()
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
            oldCityName = cityName
            searchViewModel.searchText = cityName
            searchViewModel.loadRecentSearches()
        }
    }

    private func submitSearch() {
        searchViewModel.searchByName(cityName: $cityName) { coordinate in
            Task {
                await viewModel.loadWeather(
                    lat: coordinate.latitude,
                    lon: coordinate.longitude
                )

                let temp = "\(Int(viewModel.weather?.current?.temperature_2m.rounded() ?? 0))°"

                searchViewModel.addRecentSearch(
                    city: cityName,
                    lat: coordinate.latitude,
                    lon: coordinate.longitude,
                    temperature: temp
                )
            }
        }
    }

    private func selectCity(city: String, lat: Double, lon: Double) {
        cityName = city
        searchViewModel.searchText = city
        searchViewModel.selectedCoordinate = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )
        searchViewModel.closeSearchCard()

        Task {
            await viewModel.loadWeather(lat: lat, lon: lon)
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
