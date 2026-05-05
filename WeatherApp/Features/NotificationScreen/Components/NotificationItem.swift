//
//  SwiftUIView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct NotificationItem: View {
    let icon: String
    let time: String
    let message: String
    let isNew: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text(time)
                    .font(.custom("Overpass-Bold", size: 12))
                    .foregroundColor(.secondary)

                Text(message)
                    .font(.custom("Overpass-Bold", size: 16))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.3))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image("up")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.top, 4)
        }
        .padding(.leading, 31)
        .padding(.trailing, 31)
        .padding(.vertical, 16)
        .background(isNew ? Color.blue.opacity(0.08) : Color.clear)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}
#Preview {
    NotificationItem(icon: "Suny", time: "10 minutes ago", message: "A sunny day in your location, consider wearing your UV protection", isNew:  true)
}
