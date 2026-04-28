//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//
import SwiftUI

struct WeatherDetails: View {
    @ObservedObject var viewModel: WeatherViewModel
    @StateObject private var detailsViewModel = WeatherDetailsViewModel()

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

                        Text(detailsViewModel.currentTemp)
                            .font(.system(size: 18, weight: .medium))
                    }

                    Spacer()

                    Text(detailsViewModel.formattedDate)
                        .font(.system(size: 16))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 37)

                HourlyCardView(items: detailsViewModel.hourlyItems)

                DailyForecastSectionView(items: detailsViewModel.dailyItems)

                Spacer()
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            detailsViewModel.configure(with: viewModel.weather)
        }
        .onChange(of: viewModel.weather?.current?.time) { _ in
            detailsViewModel.configure(with: viewModel.weather)
        }
    }
}

#Preview {
    NavigationStack {
        WeatherDetails(viewModel: WeatherViewModel())
    }
}
