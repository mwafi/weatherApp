//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Mohammed Hassanien on 28/04/2026.
//

import XCTest
@testable import WeatherApp

final class WeatherServiceTests: XCTestCase {

    func testFetchWeatherSuccess() async throws {
        let mockSession = MockURLSession()
        mockSession.data = WeatherTestFixtures.validWeatherJSON
        mockSession.response = WeatherTestFixtures.successHTTPResponse()

        let service = WeatherService(session: mockSession)

        let result = try await service.fetchWeather(
            lat: WeatherTestFixtures.latitude,
            lon: WeatherTestFixtures.longitude
        )

        XCTAssertEqual(result.current?.temperature_2m, WeatherTestFixtures.temperature)
        XCTAssertEqual(result.current?.wind_speed_10m, WeatherTestFixtures.windSpeed)
        XCTAssertEqual(result.current?.weather_code, WeatherTestFixtures.weatherCode)
        XCTAssertEqual(result.current?.relative_humidity_2m, WeatherTestFixtures.humidity)

        XCTAssertEqual(result.hourly?.temperature_2m.first, WeatherTestFixtures.temperature)
        XCTAssertEqual(result.hourly?.wind_speed_10m.first, WeatherTestFixtures.windSpeed)
        XCTAssertEqual(result.hourly?.weather_code.first, WeatherTestFixtures.weatherCode)
        XCTAssertEqual(result.hourly?.relative_humidity_2m.first, WeatherTestFixtures.humidity)

        XCTAssertEqual(result.daily?.temperature_2m_max.first, WeatherTestFixtures.maxTemperature)
        XCTAssertEqual(result.daily?.temperature_2m_min.first, WeatherTestFixtures.minTemperature)
        XCTAssertEqual(result.daily?.weather_code.first, WeatherTestFixtures.weatherCode)
    }

    func testFetchWeatherBadServerResponseThrowsError() async {
        let mockSession = MockURLSession()
        mockSession.data = Data()
        mockSession.response = WeatherTestFixtures.serverErrorHTTPResponse()

        let service = WeatherService(session: mockSession)

        do {
            _ = try await service.fetchWeather(
                lat: WeatherTestFixtures.latitude,
                lon: WeatherTestFixtures.longitude
            )

            XCTFail("Expected bad server response error")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testFetchWeatherInvalidJSONThrowsError() async {
        let mockSession = MockURLSession()
        mockSession.data = WeatherTestFixtures.invalidWeatherJSON
        mockSession.response = WeatherTestFixtures.successHTTPResponse()

        let service = WeatherService(session: mockSession)

        do {
            _ = try await service.fetchWeather(
                lat: WeatherTestFixtures.latitude,
                lon: WeatherTestFixtures.longitude
            )

            XCTFail("Expected decoding error")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testFetchWeatherNetworkErrorThrowsError() async {
        let mockSession = MockURLSession()
        mockSession.error = URLError(.notConnectedToInternet)

        let service = WeatherService(session: mockSession)

        do {
            _ = try await service.fetchWeather(
                lat: WeatherTestFixtures.latitude,
                lon: WeatherTestFixtures.longitude
            )

            XCTFail("Expected network error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
