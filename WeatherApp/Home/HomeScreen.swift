//
//  HomeScreen.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        ZStack {
            HomeBackgroundView()
            
            VStack(spacing: 0) {
                HomeHeaderView(cityName: "Semarang")
                    .padding(.top, 18)
                
                Spacer()
                    .frame(height: 55)
                
                WeatherIllustrationView(conditionName: "Cloudy")
                
                Spacer()
                    .frame(height: 30)
                
                CurrentWeatherCardView(
                    dateText: "Today, 12 September",
                    temperatureText: "29°",
                    conditionText: "Cloudy",
                    windText: "10 km/h",
                    humidityText: "54 %"
                )
                
                Spacer()
                    .frame(height: 100)
                
                ForecastReportButtonView()
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
