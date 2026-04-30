//
//  RecentSearchRow.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI

struct RecentSearchRow: View {
    let city: String
    let temperature: String

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "clock")
                .font(.system(size: 18))
                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))

            Text(city)
                .font(.custom("Overpass-Medium", size: 18))                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
                .padding(.leading, 15)

            Spacer()

            Text(temperature)
                .font(.custom("Overpass-Medium", size: 18))                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
        }
        .scrollContentBackground(.hidden)
        .frame(height: 45)
    }
}
    #Preview {
        RecentSearchRow(city: "Surabaya", temperature: "34°")
            .padding(.horizontal, 31)
    }
