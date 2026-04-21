//
//  SearchBarComponent.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//

import SwiftUI

struct SearchBarComponent: View {
    var body: some View {
        HStack(spacing:12)
        {
            Button(action: {
                           //  action
                       }) {
                           Image(systemName: "arrow.left")
                               .font(.system(size: 20, weight: .medium))
                               .foregroundColor(Color(red: 0.29, green: 0.35, blue: 0.53))
                       }
            Text("Search here")
                           .font(.system(size: 16, weight: .medium))
                           .foregroundColor(Color(red: 0.50, green: 0.54, blue: 0.67))
                       
                       Spacer()
                       
                       Button(action: {
                       }) {
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
    SearchBarComponent()
        .padding()
                
}
