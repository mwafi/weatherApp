//
//  ConfirmLocation.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 28/04/2026.
//

import SwiftUI

import SwiftUI

struct ConfirmLocation: View {
    var onBack: () -> Void

    var body: some View {
        Button(action: onBack) {
            HStack(spacing: 8) {
                Image(systemName: "checkmark")
                    .font(.system(size: 13, weight: .bold))

                Text("Confirm")
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .frame(height: 46)
            .background(
                Capsule()
                    .fill(Color(red: 0.29, green: 0.35, blue: 0.53))
            )
            .overlay(
                Capsule()
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.22), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.25).ignoresSafeArea()

        VStack {
            Spacer()
            ConfirmLocation(onBack: {})
                .padding(.bottom, 34)
        }
    }
}
