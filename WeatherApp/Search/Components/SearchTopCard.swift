//
//  SearchTopCard.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI

struct SearchTopCard: View {
    @Binding var searchText: String
    let recentSearches: [(city: String, lat: Double, lon: Double, temperature: String)]
    var onSelectCity: (String, Double, Double) -> Void
    var onSearchSubmit: () -> Void
    var onClose: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            SearchBarComponent(
                text: $searchText,
                onTap: {},
                onBack: onClose,
                isExpanded: true,
                onSubmit: {
                    onSearchSubmit()
                }
            )

            VStack(alignment: .leading, spacing: 24) {
                Text("Recent search")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))

                VStack(spacing: 28) {
                    ForEach(recentSearches, id: \.city) { item in
                        Button {
                            onSelectCity(item.city, item.lat, item.lon)
                        } label: {
                            RecentSearchRow(
                                city: item.city,
                                temperature: item.temperature
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, 28)
        .padding(.top, 58)
        .padding(.bottom, 34)
        .frame(maxWidth: .infinity, maxHeight: 430, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
        )
    }
}
