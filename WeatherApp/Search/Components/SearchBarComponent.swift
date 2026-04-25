//
//  SearchBarComponent.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI

struct SearchBarComponent: View {
    @Binding var text: String
    var onTap: () -> Void
    var onBack: () -> Void
    var isExpanded: Bool = false
    var onSubmit: () -> Void = {}

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
            }

            TextField("Search here", text: $text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
                .disabled(!isExpanded)
                .allowsHitTesting(isExpanded)
                .submitLabel(.search)
                .onSubmit {
                    onSubmit()
                }

            Spacer()

            Button(action: {
                onSubmit()
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
            }
        }
        .padding(.horizontal, 18)
        .frame(height: 56)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}
#Preview {
    SearchBarComponent(
        text: .constant(""),
        onTap: {},
        onBack: {},
        isExpanded: false,
        onSubmit: {}
    )
    .padding()
}
