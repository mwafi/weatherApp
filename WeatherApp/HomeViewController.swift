//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 19/04/2026.
//

import Foundation
import UIKit
class HomeViewController:UIViewController
{
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var forecastButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var weatherCardView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
  
        private let backgroundGradient = CAGradientLayer()
        private let cardGradient = CAGradientLayer()
        private let weatherService: WeatherServiceProtocol = WeatherService()

        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            fetchWeatherData()
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            backgroundGradient.frame = backgroundView.bounds
            cardGradient.frame = weatherCardView.bounds
            applyButtonShadow()
        }
    }

    // MARK: - UI Setup
    private extension HomeViewController {

        func setupUI() {
            setupBackgroundView()
            setupWeatherCardView()
            setupLabelsStyle()
            setupWeatherImage()
        }

        func setupBackgroundView() {
            backgroundView.layer.cornerRadius = 24
            backgroundView.clipsToBounds = true

            backgroundGradient.colors = [
                UIColor(red: 93/255, green: 191/255, blue: 231/255, alpha: 1.0).cgColor,
                UIColor(red: 79/255, green: 139/255, blue: 244/255, alpha: 1.0).cgColor
            ]
            backgroundGradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            backgroundGradient.endPoint = CGPoint(x: 0.5, y: 1.0)

            if backgroundGradient.superlayer == nil {
                backgroundView.layer.insertSublayer(backgroundGradient, at: 0)
            }
        }

        func setupWeatherCardView() {
            weatherCardView.layer.cornerRadius = 30
            weatherCardView.clipsToBounds = true
            weatherCardView.backgroundColor = UIColor.white.withAlphaComponent(0.10)
            weatherCardView.layer.borderWidth = 1.2
            weatherCardView.layer.borderColor = UIColor.white.withAlphaComponent(0.24).cgColor

            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = weatherCardView.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            cardGradient.colors = [
                UIColor.white.withAlphaComponent(0.15).cgColor,
                UIColor.white.withAlphaComponent(0.05).cgColor
            ]
            weatherCardView.layer.insertSublayer(cardGradient, at: 1)
        }

        func setupLabelsStyle() {
            tempLabel.font = UIFont.systemFont(ofSize: 92, weight: .light)
            [dateLabel, tempLabel, conditionLabel, windValueLabel, humidityValueLabel].forEach {
                applySoftShadow(to: $0)
            }
        }

        func setupWeatherImage() {
            weatherImageView.contentMode = .scaleAspectFit
            weatherImageView.image = UIImage(named: "Group 650 (2)")
        }

        func applySoftShadow(to label: UILabel) {
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowOpacity = 0.15
            label.layer.shadowOffset = CGSize(width: 0, height: 2)
            label.layer.shadowRadius = 4
            label.layer.masksToBounds = false
        }

        func applyButtonShadow() {
            forecastButton.layer.cornerRadius = 20
            forecastButton.layer.shadowColor = UIColor.black.cgColor
            forecastButton.layer.shadowOpacity = 0.14
            forecastButton.layer.shadowOffset = CGSize(width: 0, height: 8)
            forecastButton.layer.shadowRadius = 12
        }
    }

    // MARK: - Networking & Data Binding
    private extension HomeViewController {

        func fetchWeatherData() {
            let lat = 30.0444
                let lon = 31.2357
            
            Task {
                do {
                    let response = try await weatherService.fetchWeather(lat: lat, lon: lon)
                    
                    await MainActor.run {
                        self.displayWeather(from: response)
                    }
                } catch {
                    print("DEBUG: Error fetching weather: \(error.localizedDescription)")
                }
            }
        }
        func displayWeather(from response: WeatherResponse) {
          
                let currentTemp = Int(response.current.temperature_2m)
                self.tempLabel.text = "\(currentTemp)°"
                
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, d MMMM"
                self.dateLabel.text = formatter.string(from: response.current.time)
                
                self.tempLabel.textColor = .white
           
        }
    }
