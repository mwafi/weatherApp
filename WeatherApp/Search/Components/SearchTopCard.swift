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

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            SearchBarComponent(text: $searchText)

            VStack(alignment: .leading, spacing: 24) {
                Text("Recent search")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))

                VStack(spacing: 28) {
                    ForEach(recentSearches, id: \.city) { item in
                        Button(action: {
                            withAnimation(.spring()) { searchText = item.city
                            }
                        }) {
                            RecentSearchRow()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(.horizontal, 28)
        .padding(.top, 58)
        .padding(.bottom, 34)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.white)                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
        )
    }
}
#Preview {
    SearchTopCard(
        searchText: .constant(""),
        recentSearches: [
            (city: "Cupertino", high: "23°", low: "12°"),
            (city: "London", high: "18°", low: "9°"),
            (city: "Tokyo", high: "26°", low: "17°")
        ]
    )
}
