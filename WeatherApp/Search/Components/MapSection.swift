//
//  MapSection.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI
import MapKit

struct MapSection: View {
    @ObservedObject var viewModel: WeatherViewModel

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -2.5, longitude: 118.0),
        span: MKCoordinateSpan(latitudeDelta: 18, longitudeDelta: 18)
    )

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(
                coordinateRegion: $region,
                annotationItems: getAnnotations()
            ) { location in
                MapAnnotation(coordinate: location.coord) {
                    MapMarkerView()
                }
            }
            .ignoresSafeArea()
            .onChange(of: viewModel.weather?.latitude) { _ in
                guard let weather = viewModel.weather else { return }

                withAnimation(.easeInOut) {
                    region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: weather.latitude,
                            longitude: weather.longitude
                        ),
                        span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
                    )
                }
            }

            CurrentLocationButton {
                if let weather = viewModel.weather {
                    withAnimation(.easeInOut) {
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: weather.latitude,
                                longitude: weather.longitude
                            ),
                            span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
                        )
                    }
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 70)
        }
    }

    private func getAnnotations() -> [IdentifiableLocation] {
        guard let weather = viewModel.weather else { return [] }

        return [
            IdentifiableLocation(
                coord: CLLocationCoordinate2D(
                    latitude: weather.latitude,
                    longitude: weather.longitude
                )
            )
        ]
    }
}

struct IdentifiableLocation: Identifiable {
    let id = UUID()
    let coord: CLLocationCoordinate2D
}

#Preview {
    MapSection(viewModel: WeatherViewModel())
}
