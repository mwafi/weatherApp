//
//  HomeHeaderView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct HomeHeaderView: View {
    
    var cityName: String = "Semarang"
    
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
                print("Open notifications")
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
    HomeHeaderView()
}
