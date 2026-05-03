//
//  WeatherUIState.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 03/05/2026.
//

import Foundation
enum WeatherUIState
{
    case idle
    case loading
    case success(WeatherUIModel)
    case failure(String)
}
