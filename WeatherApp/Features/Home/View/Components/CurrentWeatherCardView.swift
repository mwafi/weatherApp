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
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white.opacity(0.95))
                .padding(.top, 24)

            Text(temperatureText)
                .font(.system(size: 88, weight: .thin))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.98),
                            Color.white.opacity(0.86)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: .white.opacity(0.12), radius: 1, x: 0, y: -1)
                .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 4)
                .padding(.top, 10)

            Text(conditionText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 3)
                .padding(.top, 8)

            VStack(spacing: 16) {
                HStack(spacing: 0) {
                    Image("windy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Spacer().frame(width: 14)

                    Text("Wind")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .frame(width: 42, alignment: .leading)

                    Text("|")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.white.opacity(0.70))
                        .frame(width: 18, alignment: .center)

                    Text(windText)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .frame(width: 78, alignment: .leading)
                }

                HStack(spacing: 0) {
                    Image("hum")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Spacer().frame(width: 14)

                    Text("Hum")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .frame(width: 42, alignment: .leading)

                    Text("|")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.white.opacity(0.70))
                        .frame(width: 18, alignment: .center)

                    Text(humidityText)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .frame(width: 78, alignment: .leading)
                }
            }
            .frame(width: 170)
            .padding(.top, 28)

            Spacer()
        }
        .frame(width: 300, height: 300)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.08))

                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial.opacity(0.22))

                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.26), lineWidth: 1)

                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.08), lineWidth: 0.5)
                    .blur(radius: 1)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 14,
            x: 0,
            y: 8
        )
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
