//
//  SearchBarComponent.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//

import SwiftUI

struct SearchBarComponent: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: { /*  Action */ }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
            }
            
            TextField("Search here", text: $text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
            
            Spacer()
            
            Button(action: { /*  Action */ }) {
                Image(systemName: "mic.fill")
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
    }
}
#Preview {
    SearchBarComponent(text: .constant(""))
        .padding()
}

