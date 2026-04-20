//
//  HomeBackgroundView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct HomeBackgroundView: View {
    var body: some View {
        ZStack
        {
            
            LinearGradient(
        colors:
            [
            Color(red: 0.30, green: 0.72, blue: 0.93),
            Color(red: 0.30, green: 0.54, blue: 0.98)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
            
            Image("Vector 12")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 112, height: 235)
                    .opacity(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: -25, y: 92)
                        
            Image("Vector 11")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 425, height: 366.5)
                    .opacity(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 59, y: -54)
            
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeBackgroundView()
}
