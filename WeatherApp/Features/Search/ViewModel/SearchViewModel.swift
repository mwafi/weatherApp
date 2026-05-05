//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 26/04/2026.
//

import Foundation
import CoreLocation
internal import Combine
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var searchText = ""
    @Published var showSearchCard = false
    @Published var selectedCoordinate: CLLocationCoordinate2D?
    @Published var recentSearches: [RecentSearchItem] = []

    func openSearchCard() {
        withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
            showSearchCard = true
        }
    }

    func closeSearchCard() {
        withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
            showSearchCard = false
        }
    }

    func searchByName(
        cityName: Binding<String>,
        onResult: @escaping (CLLocationCoordinate2D) -> Void
    ) {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        CLGeocoder().geocodeAddressString(trimmed) { [weak self] placemarks, error in
            guard let self else { return }

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

            Task { @MainActor in
                cityName.wrappedValue = resultName
                self.searchText = resultName
                self.selectedCoordinate = coordinate
                self.closeSearchCard()

                onResult(coordinate)
            }
        }
    }

    func addRecentSearch(
        city: String,
        lat: Double,
        lon: Double,
        temperature: String
    ) {
        recentSearches.removeAll {
            $0.city.lowercased() == city.lowercased()
        }

        recentSearches.insert(
            RecentSearchItem(
                city: city,
                lat: lat,
                lon: lon,
                temperature: temperature
            ),
            at: 0
        )

        if recentSearches.count > 5 {
            recentSearches = Array(recentSearches.prefix(5))
        }

        saveRecentSearches()
    }

    private func saveRecentSearches() {
        if let data = try? JSONEncoder().encode(recentSearches) {
            UserDefaults.standard.set(data, forKey: "recentSearches")
        }
    }

    func loadRecentSearches() {
        guard let data = UserDefaults.standard.data(forKey: "recentSearches"),
              let saved = try? JSONDecoder().decode([RecentSearchItem].self, from: data)
        else { return }

        recentSearches = saved
    }
}
