//
//  ForecastReportButtonView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI
import SwiftUI

struct ForecastReportButtonView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationLink {
            WeatherDetails(viewModel: viewModel)
        } label: {
            HStack(spacing: 10) {
                Text("Forecast report")
                    .font(.custom("Overpass-Bold", size: 17))
                    .foregroundColor(Color(red: 0.29, green: 0.33, blue: 0.50))

                Image("up (6)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .rotationEffect(.degrees(180))
            }
            .frame(width: 170, height: 56)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.96))
                    .shadow(color: .black.opacity(0.10), radius: 10, x: 0, y: 6)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ForecastReportButtonView(viewModel: WeatherViewModel())
    }
}
