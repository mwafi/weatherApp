//
//  DailyForecastSectionView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct DailyForecastSectionView: View {
    
    let forecastItems: [DailyForecastItem] = [
        DailyForecastItem(date: "Sep, 13", icon: "thunder", temp: "21°"),
        DailyForecastItem(date: "Sep, 14", icon: "rain", temp: "22°"),
        DailyForecastItem(date: "Sep, 15", icon: "sunny", temp: "34°"),
        DailyForecastItem(date: "Sep, 16", icon: "rain", temp: "27°"),
        DailyForecastItem(date: "Sep, 17", icon: "sun cloudy", temp: "32°")
    ]
    
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
                ForEach(forecastItems) { item in
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

struct DailyForecastItem: Identifiable {
    let id = UUID()
    let date: String
    let icon: String
    let temp: String
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [
                Color(red: 0.33, green: 0.73, blue: 0.94),
                Color(red: 0.29, green: 0.56, blue: 0.95)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        DailyForecastSectionView()
    }
}
