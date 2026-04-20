//
//  HomeHeaderView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct HomeHeaderView: View {
    
    var cityName: String = "Semarang"
    @Binding var showNotifications: Bool
    
    var body: some View {
        HStack {
            Button {
                print("Open city picker")
            } label: {
                HStack(spacing: 8) {
                    Image("map")
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text(cityName) 
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Image("opt")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 0.28)) {
                                    showNotifications = true
                                }
            } label: {
                Image("Group 652")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
}
#Preview {
    HomeHeaderView(showNotifications: .constant(false))
        .background(Color.blue) // عشان تشوف الأيقونات البيضاء
}
