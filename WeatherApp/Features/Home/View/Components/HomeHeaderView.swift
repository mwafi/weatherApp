//
//  HomeHeaderView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
import SwiftUI

struct HomeHeaderView: View {
    @Binding var cityName: String
    @Binding var showNotifications: Bool
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        HStack {
            NavigationLink {
                SearchView(
                    cityName: $cityName,
                    viewModel: viewModel
                )
            } label: {
                HStack(spacing: 8) {
                    Image("map")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .accessibilityIdentifier("cityLocationIcon")

                    Text(cityName)
                        .font(.custom("Overpass-Bold", size: 23))
                        .foregroundColor(.white)
                        .accessibilityIdentifier("homeCityNameText")

                    Image("opt")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .accessibilityIdentifier("cityDropdownIcon")
                }
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("citySearchNavigationButton")

            Spacer()

            Button {
                showNotifications = true
            } label: {
                Image("Group 652")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .accessibilityIdentifier("notificationsIcon")
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("notificationsButton")
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .accessibilityIdentifier("homeHeaderView")
    }
}
#Preview {
    NavigationStack {
        ZStack {
            Color.blue.ignoresSafeArea()
            HomeHeaderView(
                cityName: .constant("Jerusalem"),
                showNotifications: .constant(false),
                viewModel: WeatherViewModel()
            )
        }
    }
}
