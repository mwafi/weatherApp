//
//  HomeScreen.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct HomeScreen: View {
    @State private var showNotifications = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                HomeBackgroundView()
                
                VStack(spacing: 0) {
                    HomeHeaderView(cityName: "Semarang", showNotifications: $showNotifications)
                        .padding(.top, 18)
                    
                    Spacer()
                        .frame(height: 55)
                    
                    WeatherIllustrationView(conditionName: "Cloudy")
                    
                    Spacer()
                        .frame(height: 30)
                    
                    CurrentWeatherCardView()
                    
                    Spacer()
                        .frame(height: 100)
                    
                    ForecastReportButtonView()
                    
                    Spacer()
                }
                
                if showNotifications {
                    NotificationsOverlayView(isPresented: $showNotifications)
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeScreen()
}
