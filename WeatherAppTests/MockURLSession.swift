//
//  MockURLSession.swift
//  WeatherAppTests
//
//  Created by Mohammed Hassanien on 28/04/2026.
//

import Foundation

@testable import WeatherApp

final class MockURLSession: URLSessionProtocol {

    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }

        return (
            data ?? Data(),
            response ?? HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )
    }
}
