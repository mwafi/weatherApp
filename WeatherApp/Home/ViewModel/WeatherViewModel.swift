//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 22/04/2026.
//

import Foundation
internal import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService = WeatherService()

    func loadWeather() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await weatherService.fetchWeather(lat: -6.9667, lon: 110.4167)
            self.weather = result
        } catch {
            self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadWeather(lat: Double, lon: Double) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await weatherService.fetchWeather(lat: lat, lon: lon)
            self.weather = result
        } catch {
            self.errorMessage = "Failed: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
