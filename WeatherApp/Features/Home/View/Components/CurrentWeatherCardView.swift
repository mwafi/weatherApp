//
//  CurrentWeatherCardView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//
import SwiftUI

struct CurrentWeatherCardView: View {
    var dateText: String
    var temperatureText: String
    var conditionText: String
    var windText: String
    var humidityText: String

    var body: some View {
        VStack(spacing: 0) {
            
            Text(dateText)
                .font(.custom("Overpass-Regular", size: 17))
                .foregroundColor(.white.opacity(0.95))
                .shadow(color: .white.opacity(0.25), radius: 1, x: -1, y: -1)
                .shadow(color: .black.opacity(0.18), radius: 3, x: 2, y: 2)
                .padding(.top, 24)

            Text(temperatureText)
                .font(.custom("Overpass-Bold", size: 93))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.white,
                            Color.white.opacity(0.78)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: .white.opacity(0.35), radius: 2, x: -2, y: -2)
                .shadow(color: .black.opacity(0.20), radius: 8, x: 4, y: 5)
                .padding(.top, 10)

            Text(conditionText)
                .font(.custom("Overpass-Bold", size: 22))
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.25), radius: 1, x: -1, y: -1)
                .shadow(color: .black.opacity(0.18), radius: 4, x: 2, y: 3)
                .padding(.top, 8)

            VStack(spacing: 16) {
                
                HStack(spacing: 0) {
                    Image("windy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Spacer().frame(width: 14)

                    Text("Wind")
                        .font(.custom("Overpass-Light", size: 17))
                        .foregroundColor(.white)
                        .shadow(color: .white.opacity(0.2), radius: 1, x: -1, y: -1)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 1, y: 2)
                        .frame(width: 42, alignment: .leading)

                    Text("|")
                        .font(.custom("Overpass-Light", size: 17))
                        .foregroundColor(.white.opacity(0.7))
                        .frame(width: 18)

                    Text(windText)
                        .font(.custom("Overpass-Light", size: 17))
                        .foregroundColor(.white)
                        .shadow(color: .white.opacity(0.2), radius: 1, x: -1, y: -1)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 1, y: 2)
                        .frame(width: 78, alignment: .leading)
                }

                HStack(spacing: 0) {
                    Image("hum")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Spacer().frame(width: 14)

                    Text("Hum")
                        .font(.custom("Overpass-Light", size: 17))
                        .foregroundColor(.white)
                        .shadow(color: .white.opacity(0.2), radius: 1, x: -1, y: -1)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 1, y: 2)
                        .frame(width: 42, alignment: .leading)

                    Text("|")
                        .font(.custom("Overpass-Light", size: 17))
                        .foregroundColor(.white.opacity(0.7))
                        .frame(width: 18)

                    Text(humidityText)
                        .font(.custom("Overpass-Light", size: 17))
                        .foregroundColor(.white)
                        .shadow(color: .white.opacity(0.2), radius: 1, x: -1, y: -1)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 1, y: 2)
                        .frame(width: 78, alignment: .leading)
                }
            }
            .frame(width: 170)
            .padding(.top, 28)

            Spacer()
        }
        .frame(width: 300, height: 300)
        
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.52, green: 0.75, blue: 0.92),
                            Color(red: 0.42, green: 0.67, blue: 0.88)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .white.opacity(0.45), radius: 10, x: -6, y: -6)
                .shadow(color: .black.opacity(0.18), radius: 12, x: 7, y: 7)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [
                Color(red: 0.30, green: 0.72, blue: 0.93),
                Color(red: 0.30, green: 0.54, blue: 0.98)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        CurrentWeatherCardView(
            dateText: "Today, 12 September",
            temperatureText: "29°",
            conditionText: "Cloudy",
            windText: "10 km/h",
            humidityText: "54 %"
        )
    }
}
