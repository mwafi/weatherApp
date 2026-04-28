//
//  MapSection.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 21/04/2026.
//
import SwiftUI
import MapKit
import CoreLocation

struct MapSection: View {

    @ObservedObject var viewModel: WeatherViewModel
    
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var cityName: String
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
        span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
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

            CurrentLocationButton {
                locationManager.requestCurrentLocation()
                openGPSLocation()
            }
            .padding(.trailing, 20)
            .padding(.bottom, 70)
        }
        .onAppear {
            locationManager.requestCurrentLocation()
        }
        .onReceive(locationManager.$coordinate) { coordinate in
            guard let coordinate = coordinate else { return }

            selectedCoordinate = nil

            withAnimation(.easeInOut) {
                region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.02,
                        longitudeDelta: 0.02
                    )
                )
            }

            Task {
                await viewModel.loadWeather(
                    lat: coordinate.latitude,
                    lon: coordinate.longitude
                )
            }
        }
        .onReceive(locationManager.$cityName) { name in
            guard let name = name else { return }
            cityName = name
        }
        .onChange(of: selectedCoordinate?.latitude) { _ in
            openSearchLocation()
        }
    }

    private func openGPSLocation() {
        guard let gpsCoordinate = locationManager.coordinate else { return }

        selectedCoordinate = nil

        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(
                center: gpsCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        }

        if let name = locationManager.cityName {
            cityName = name
        }

        Task {
            await viewModel.loadWeather(
                lat: gpsCoordinate.latitude,
                lon: gpsCoordinate.longitude
            )
        }
    }

    private func openSearchLocation() {
        guard let searchCoordinate = selectedCoordinate else { return }

        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(
                center: searchCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4)
            )
        }

        Task {
            await viewModel.loadWeather(
                lat: searchCoordinate.latitude,
                lon: searchCoordinate.longitude
            )
        }
    }
    private func getAnnotations() -> [IdentifiableLocation] {
        if let selectedCoordinate {
            return [IdentifiableLocation(coord: selectedCoordinate)]
        }

        if let gpsCoordinate = locationManager.coordinate {
            return [IdentifiableLocation(coord: gpsCoordinate)]
        }

        return []
    }
}

#Preview {
    MapSection(
        viewModel: WeatherViewModel(),
        selectedCoordinate: .constant(nil),
        cityName: .constant("")
    )
}
