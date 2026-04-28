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
        let json = """
        {
          "latitude": 52.52,
          "longitude": 13.4,
          "generationtime_ms": 0.05078315734863281,
          "utc_offset_seconds": 0,
          "timezone": "GMT",
          "timezone_abbreviation": "GMT",
          "elevation": 38,
          "current": {
            "time": "2026-04-28T02:00",
            "temperature_2m": 6.1,
            "wind_speed_10m": 12.3,
            "weather_code": 2,
            "relative_humidity_2m": 47
          },
          "hourly": {
            "time": ["2026-04-28T02:00"],
            "temperature_2m": [6.1],
            "wind_speed_10m": [12.3],
            "weather_code": [2],
            "relative_humidity_2m": [47]
          },
          "daily": {
            "time": ["2026-04-28"],
            "weather_code": [2],
            "temperature_2m_max": [12.0],
            "temperature_2m_min": [4.0]
          }
        }
        """.data(using: .utf8)!

        let mockSession = MockURLSession()
        mockSession.data = json
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://api.open-meteo.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let service = WeatherService(session: mockSession)

        let result = try await service.fetchWeather(lat: 52.52, lon: 13.4)

        XCTAssertEqual(result.current?.temperature_2m, 6.1)
        XCTAssertEqual(result.current?.wind_speed_10m, 12.3)
        XCTAssertEqual(result.current?.weather_code, 2)
        XCTAssertEqual(result.current?.relative_humidity_2m, 47)

        XCTAssertEqual(result.hourly?.temperature_2m.first, 6.1)
        XCTAssertEqual(result.hourly?.wind_speed_10m.first, 12.3)
        XCTAssertEqual(result.hourly?.weather_code.first, 2)
        XCTAssertEqual(result.hourly?.relative_humidity_2m.first, 47)

        XCTAssertEqual(result.daily?.temperature_2m_max.first, 12.0)
        XCTAssertEqual(result.daily?.temperature_2m_min.first, 4.0)
        XCTAssertEqual(result.daily?.weather_code.first, 2)
    }

    func testFetchWeatherBadServerResponseThrowsError() async {
        let mockSession = MockURLSession()
        mockSession.data = Data()
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://api.open-meteo.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        let service = WeatherService(session: mockSession)

        do {
            _ = try await service.fetchWeather(lat: 52.52, lon: 13.4)
            XCTFail("Expected badServerResponse error")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testFetchWeatherInvalidJSONThrowsError() async {
        let invalidJSON = """
        {
          "current": "invalid"
        }
        """.data(using: .utf8)!

        let mockSession = MockURLSession()
        mockSession.data = invalidJSON
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://api.open-meteo.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let service = WeatherService(session: mockSession)

        do {
            _ = try await service.fetchWeather(lat: 52.52, lon: 13.4)
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
            _ = try await service.fetchWeather(lat: 52.52, lon: 13.4)
            XCTFail("Expected network error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
