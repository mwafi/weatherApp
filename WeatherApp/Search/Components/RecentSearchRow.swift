//
//  RecentSearchRow.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI

struct RecentSearchRow: View {
    let city: String
    let high: String
    let low: String

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "clock")
                .font(.system(size: 22))
                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))

            Text(city)
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
                .padding(.leading, 15)

            Spacer()

            Text("\(high) / \(low)")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
        }
        .frame(height: 45)
    }
}

#Preview {
    RecentSearchRow(city: "Surabaya", high: "34°", low: "23°")
        .padding(.horizontal, 31)
}
