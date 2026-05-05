//
//  SwiftUIView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct NotificationsScreen: View {
    @State private var showNotifications = true

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.7),
                    Color.blue.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if showNotifications {
                NotificationsOverlayView(isPresented: $showNotifications)
            }
        }
    }
}

#Preview {
    NotificationsScreen()
}

