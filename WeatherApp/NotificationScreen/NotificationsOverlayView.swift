//
//  NotificationsOverlayView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct NotificationsOverlayView: View {
    @Binding var isPresented: Bool

    var body: some View {
        ZStack(alignment: .bottom) {

            Color.black.opacity(0.15)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isPresented = false
                    }
                }

            NotificationsSheetView()
                .transition(.move(edge: .bottom))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NotificationsOverlayView(isPresented: .constant(true))
}
