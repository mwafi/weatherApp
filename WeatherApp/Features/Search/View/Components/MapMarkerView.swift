//
//  MapMarkerView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//

import SwiftUI

struct MapMarkerView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 36))
                .foregroundColor(.red)
                .background(
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                )
                .shadow(radius: 4)

            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 10, height: 6)
                .rotationEffect(.degrees(180))
                .foregroundColor(.red)
                .offset(y: -4)
        }
        .offset(y: -18)
    }
}

#Preview {
    MapMarkerView()
}
