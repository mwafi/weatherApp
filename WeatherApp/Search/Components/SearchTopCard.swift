//
//  SearchTopCard.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//

import SwiftUI

struct SearchTopCard: View {
    @Binding var searchText: String
    let recentSearches: [(city: String, high: String, low: String)]
    var onClose: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            SearchBarComponent(
                text: $searchText,
                onTap: {},
                onBack: onClose,
                isExpanded: true
            )

            VStack(alignment: .leading, spacing: 24) {
                Text("Recent search")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))

                VStack(spacing: 28) {
                    ForEach(recentSearches, id: \.city) { item in
                        Button {
                            withAnimation(.spring()) {
                                searchText = item.city
                            }
                        } label: {
                            RecentSearchRow(
                                city: item.city,
                                high: item.high,
                                low: item.low
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

#Preview {
    SearchTopCard(
        searchText: .constant(""),
        recentSearches: [
            (city: "Surabaya", high: "34°", low: "23°"),
            (city: "Semarang", high: "30°", low: "21°"),
            (city: "Yogyakarta", high: "32°", low: "21°")
        ],
        onClose: {}
    )
    .padding()
}
