//
//  WeatherIllustrationView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct WeatherIllustrationView: View {
    let conditionName: String
    
    var body: some View {
        ZStack {
            Image(conditionName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200) 
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 8)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    WeatherIllustrationView(conditionName: "Cloudy")
    
}
