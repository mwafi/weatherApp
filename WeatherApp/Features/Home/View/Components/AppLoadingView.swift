//
//  AppLoadingView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 30/04/2026.
//

import SwiftUI

struct AppLoadingView: View {
    @State private var moveCloud = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.30, green: 0.72, blue: 0.93),
                    Color(red: 0.30, green: 0.54, blue: 0.98)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                ZStack {
                    Image(systemName: "cloud.fill")
                        .font(.system(size: 110))
                        .foregroundColor(.white.opacity(0.9))
                        .offset(x: moveCloud ? 10 : -10)
                        .animation(
                            .easeInOut(duration: 1.2)
                            .repeatForever(autoreverses: true),
                            value: moveCloud
                        )
                        .accessibilityIdentifier("loadingCloudImage")

                    HStack(spacing: 16) {
                        RainDrop(delay: 0.0)
                        RainDrop(delay: 0.2)
                        RainDrop(delay: 0.4)
                    }
                    .offset(y: 72)
                    .accessibilityIdentifier("loadingRainDrops")
                }
                .frame(width: 220, height: 210)

                Text("Loading weather...")
                    .font(.custom("Overpass-Bold", size: 18))
                    .foregroundColor(.white)
                    .accessibilityIdentifier("loadingWeatherText")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .accessibilityIdentifier("appLoadingView")
        .onAppear {
            moveCloud = true
        }
    }
}
struct RainDrop: View {
    @State private var isAnimating = false
    let delay: Double

    var body: some View {
        Capsule()
            .fill(Color.white.opacity(0.85))
            .frame(width: 7, height: 22)
            .offset(y: isAnimating ? 42 : -12)
            .opacity(isAnimating ? 0.1 : 1)
            .onAppear {
                withAnimation(
                    .easeIn(duration: 0.75)
                    .repeatForever(autoreverses: false)
                    .delay(delay)
                ) {
                    isAnimating = true
                }
            }
    }
}

#Preview {
    AppLoadingView()
}
