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

            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                        isPresented = false
                    
                }

            NotificationsSheetView()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NotificationsOverlayView(isPresented: .constant(true))
}
