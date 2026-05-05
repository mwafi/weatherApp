//
//  HourlyCardView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI
struct HourlyCardView: View {

    let items: [HourlyForecastItem]
    @State private var selectedIndex: Int = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]

                    VStack(spacing: 18) {
                        Text(item.temp)
                            .font(.custom("Overpass-Medium", size: 16))
                            .foregroundColor(.white)

                        Image(item.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        Text(item.time)
                            .font(.custom("Overpass-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                    .frame(width: 75, height: 165)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(index == selectedIndex ? Color.white.opacity(0.10) : Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(index == selectedIndex ? Color.white.opacity(0.35) : Color.clear, lineWidth: 1)
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
