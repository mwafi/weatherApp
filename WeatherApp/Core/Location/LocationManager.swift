//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 25/04/2026.
//
import Foundation
import CoreLocation
internal import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    @Published var coordinate: CLLocationCoordinate2D?
    @Published var cityName: String?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestCurrentLocation() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()

        case .denied, .restricted:
            print("Location permission denied")

        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }

        DispatchQueue.main.async {
            self.coordinate = location.coordinate
        }

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
            DispatchQueue.main.async {
                self.cityName =
                    placemarks?.first?.locality ??
                    placemarks?.first?.administrativeArea ??
                    placemarks?.first?.country
            }
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
   
