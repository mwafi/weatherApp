//
//  CurrentWeatherCardView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//
import SwiftUI

struct CurrentWeatherCardView: View {
    
    var dateText: String = "Today, 12 September"
    var temperatureText: String = "29°"
    var conditionText: String = "Cloudy"
    var windText: String = "10 km/h"
    var humidityText: String = "54 %"
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text(dateText)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white)
                .padding(.top, 24)
            
            Text(temperatureText)
                .font(.system(size: 82, weight: .light))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 6)
                .padding(.top, 10)
            
            Text(conditionText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.10), radius: 4, x: 0, y: 3)
                .padding(.top, 10)
            
            VStack(spacing: 16) {
                
                HStack(spacing: 0) {
                    Image("windy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    
                    Spacer()
                        .frame(width: 14)
                    
                    Text("Wind")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .frame(width: 42, alignment: .leading)
                    
                    Text("|")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.white.opacity(0.75))
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
                    
                    Spacer()
                        .frame(width: 14)
                    
                    Text("Hum")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .frame(width: 42, alignment: .leading)
                    
                    Text("|")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.white.opacity(0.75))
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
        .frame(width: 353, height: 335)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.12))
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial.opacity(0.20))
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.30), lineWidth: 1)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
        CurrentWeatherCardView()
    }
