//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct WeatherDetails: View {
    @ObservedObject var viewModel: WeatherViewModel

    private var formattedDate: String {
        guard let date = viewModel.weather?.current.time else { return "Sep, 12" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, d"
        return formatter.string(from: date)
    }

    private var currentTemp: String {
        guard let temp = viewModel.weather?.current.temperature_2m else { return "--°" }
        return "\(Int(temp.rounded()))°"
    }

    var body: some View {
        ZStack {
            HomeBackgroundView()

            VStack(spacing: 18) {
                TopBarView()
                    .padding(.horizontal, 30)

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Today")
                            .font(.system(size: 28, weight: .bold))

                        Text(currentTemp)
                            .font(.system(size: 18, weight: .medium))
                    }

                    Spacer()

                    Text(formattedDate)
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
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        WeatherDetails(viewModel: WeatherViewModel())
    }
}
