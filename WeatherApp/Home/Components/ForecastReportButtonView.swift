//
//  ForecastReportButtonView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct ForecastReportButtonView: View {
    var body: some View {
        Button {
            print("Open forecast detail")
        } label: {
            HStack(spacing: 10) {
                Text("Forecast report")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 0.29, green: 0.33, blue: 0.50))
                
                Image("up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .rotationEffect(.degrees(180))
            }
            .padding(.horizontal, 28)
            .frame(width: 220, height: 62)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ForecastReportButtonView()
}
