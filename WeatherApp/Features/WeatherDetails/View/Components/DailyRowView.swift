//
//  DailyRowView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct DailyRowView: View {
    let date: String
    let icon: String
    let temp: String
    
    var body: some View {
        HStack {
            Text(date)
                .font(.custom("Overpass-Bold", size: 17))
                .foregroundColor(.white)
            
            Spacer()
            
            Image(icon)
                .scaledToFit()
                .frame(width: 42, height: 42)
            
            Spacer()
            
            Text(temp)
                .font(.custom("Overpass-Bold", size: 17))
                .foregroundColor(.white)
                .frame(width: 50, alignment: .trailing)
        }
        .padding(.vertical, 6)
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
        
        DailyRowView(date: "Sep, 13", icon: "thunder", temp: "21°")
            .padding(.horizontal, 30)
    }
}
