//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct WeatherDetails: View {
    var body: some View {
        ZStack {
            HomeBackgroundView()
            
            VStack(spacing:18) {
                
                TopBarView()
                    .padding(.horizontal, 30)
                
                HStack {
                    Text("Today")
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    
                    Text("Sep, 12")
                        .font(.system(size: 16))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 37)
                
                HourlyCardView()
                
                DailyForecastSectionView()
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

#Preview {
    WeatherDetails()
}
