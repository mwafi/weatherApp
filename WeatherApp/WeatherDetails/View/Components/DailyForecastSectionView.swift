//
//  DailyForecastSectionView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct DailyForecastSectionView: View {

    let items: [DailyForecastItem]

    var body: some View {
        VStack(spacing: 10) {

            HStack {
                Text("Next Forecast")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "calendar")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)

            VStack(spacing: 15) {
                ForEach(items) { item in
                    DailyRowView(
                        date: item.date,
                        icon: item.icon,
                        temp: item.temp
                    )
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 32)

            Spacer()

            HStack(spacing: 10) {
                Image(systemName: "sun.max")
                    .font(.system(size: 20))
                    .foregroundColor(.white)

                Text("AccuWeather")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.bottom, 24)
        }
    }
}
