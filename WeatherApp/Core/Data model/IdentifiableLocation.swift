//
//  File.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 25/04/2026.
//

import Foundation
import CoreLocation

struct IdentifiableLocation: Identifiable {
    let id = UUID()
    let coord: CLLocationCoordinate2D
}
