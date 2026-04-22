//
//  CurrentLocationButton.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI

struct CurrentLocationButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "scope")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
                .frame(width: 56, height: 56)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CurrentLocationButton(action: {})
}
