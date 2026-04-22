//
//  MapSection.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI
import MapKit

struct MapSection: View {
    @State private var pinLocation = CLLocationCoordinate2D(
        latitude: -7.2575,
        longitude: 112.7521
    )

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -2.5, longitude: 118.0),
        span: MKCoordinateSpan(latitudeDelta: 18, longitudeDelta: 18)
    )

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            MapReader { proxy in
                Map(
                    coordinateRegion: $region,
                    annotationItems: [IdentifiableLocation(coord: pinLocation)]
                ) { location in
                    MapAnnotation(coordinate: location.coord) {
                        MapMarkerView()
                    }
                }
                .ignoresSafeArea()
                .gesture(
                    SpatialTapGesture()
                        .onEnded { value in
                            let point = value.location
                            if let coordinate = proxy.convert(point, from: .local) {
                                withAnimation(.spring()) {
                                    pinLocation = coordinate
                                }
                            }
                        }
                )
            }

            CurrentLocationButton {
                withAnimation(.easeInOut) {
                    region = MKCoordinateRegion(
                        center: pinLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
                    )
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 70)
        }
    }
}

struct IdentifiableLocation: Identifiable {
    let id = UUID()
    let coord: CLLocationCoordinate2D
}

#Preview {
    MapSection()
}
