//
//  URLSessionProtocol.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 28/04/2026.
//

import Foundation

protocol URLSessionProtocol
{
    func  data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
