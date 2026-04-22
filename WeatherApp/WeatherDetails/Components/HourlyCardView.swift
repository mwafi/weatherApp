//
//  HourlyCardView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct HourlyCardView: View {
    
    @State private var selectedIndex: Int = 2
    struct HourlyItem {
        let temp: String
        let icon: String
        let time: String
    }
    
    let hourlyItems: [HourlyItem] = [
        HourlyItem(temp: "29°C", icon: "sun cloudy", time: "15.00"),
        HourlyItem(temp: "26°C", icon: "sun cloudy", time: "16.00"),
        HourlyItem(temp: "24°C", icon: "sun cloudy", time: "17.00"),
        HourlyItem(temp: "23°C", icon: "sun cloudy", time: "18.00"),
        HourlyItem(temp: "22°C", icon: "sun cloudy", time: "19.00")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(hourlyItems.indices, id: \.self) { index in
                    let item = hourlyItems[index]
                    
                    VStack(spacing: 18) {
                        Text(item.temp)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                        
                        Image(item.icon)
                            .frame(width: 50, height: 50)
                        
                        Text(item.time)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 75, height: 165)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                index == selectedIndex
                                ? Color.white.opacity(0.10)
                                : Color.clear
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(
                                index == selectedIndex
                                ? Color.white.opacity(0.35)
                                : Color.clear,
                                lineWidth: 1
                            )
                    )
                    .shadow(
                        color: index == selectedIndex
                        ? Color.white.opacity(0.08)
                        : Color.clear,
                        radius: 8
                    )
                    .onTapGesture {
                        selectedIndex = index
                    }
                }
            }
            .padding(.horizontal, 30)
        }
    }
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
        
        HourlyCardView()
    }
}
