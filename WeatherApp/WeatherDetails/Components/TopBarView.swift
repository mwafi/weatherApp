//
//  TopBarView.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import SwiftUI

struct TopBarView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }

            Spacer()

            Button(action: {}) {
                Image(systemName: "gearshape.fill")
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.top, 10)
       }
   }


#Preview {
    NavigationStack{
        TopBarView()
    }
}
