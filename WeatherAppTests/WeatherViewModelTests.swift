//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mohammed Hassanien on 05/05/2026.
//

import XCTest
@testable import WeatherApp

@MainActor
final class WeatherViewModelTests: XCTestCase {

    func testLoadWeatherSuccessSetsWeatherAndSuccessState() async {
        let mockService = MockWeatherService(
            result: .success(WeatherTestFixtures.weatherResponse)
        )

        let viewModel = WeatherViewModel(weatherService: mockService)

        await viewModel.loadWeather(
            lat: WeatherTestFixtures.latitude,
            lon: WeatherTestFixtures.longitude
        )

        XCTAssertEqual(
            viewModel.weather?.current?.temperature_2m,
            WeatherTestFixtures.temperature
        )

        switch viewModel.state {
        case .success(let uiModel):
            XCTAssertEqual(uiModel.temperature, "6°")
            XCTAssertEqual(uiModel.wind, "12 km/h")
            XCTAssertEqual(uiModel.humidity, "47 %")

        default:
            XCTFail("Expected success state")
        }
    }
}
