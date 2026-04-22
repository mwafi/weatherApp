//
//  SearchView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI
import MapKit

struct SearchView: View {
    @State private var searchText = ""
    @State private var showSearchCard = false

    let recentSearches: [(city: String, high: String, low: String)] = [
        (city: "Surabaya", high: "34°", low: "23°"),
        (city: "Semarang", high: "30°", low: "21°"),
        (city: "Yogyakarta", high: "32°", low: "21°")
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.94, green: 0.96, blue: 0.99)
                .ignoresSafeArea()

            MapSection()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                if !showSearchCard {
                    SearchBarComponent(
                        text: $searchText,
                        onTap: {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                                showSearchCard = true
                            }
                        },
                        onBack: {},
                        isExpanded: false
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 70)
                }

                Spacer()
            }

            if showSearchCard {
                Color.black.opacity(0.10)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                            showSearchCard = false
                        }
                    }

                VStack(spacing: 0) {
                    SearchTopCard(
                        searchText: $searchText,
                        recentSearches: recentSearches,
                        onClose: {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) {
                                showSearchCard = false
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .padding(.top, 18)

                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    SearchView()
}
