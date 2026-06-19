//
//  NotificationsBottomSheetView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 20/04/2026.
//

import SwiftUI

struct NotificationsSheetView: View {
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.gray.opacity(0.35))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
                .padding(.bottom, 20)

            Text("Your notification")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.3))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 12)

            List {
                Section {
                    NotificationItem(
                        icon: "Suny",
                        time: "10 minutes ago",
                        message: "A sunny day in your location, consider wearing your UV protection",
                        isNew: true
                    )
                } header: {
                    Text("New")
                        .textCase(nil)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }

                Section {
                    NotificationItem(
                        icon: "Vector",
                        time: "1 day ago",
                        message: "A cloudy day will occur all day long, don't worry about the heat of the sun",
                        isNew: false
                    )

                    NotificationItem(
                        icon: "down",
                        time: "2 days ago",
                        message: "Potential for rain today is 84%, don't forget to bring your umbrella.",
                        isNew: false
                    )
                } header: {
                    Text("Earlier")
                        .textCase(nil)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height * 0.55)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

#Preview {
    NotificationsSheetView()
}
