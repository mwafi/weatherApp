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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDummyData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradient.frame = backgroundView.bounds
        cardGradient.frame = weatherCardView.bounds
        applyButtonShadow()
    }
}

private extension HomeViewController {

    func setupUI() {
        view.backgroundColor = UIColor(red: 236/255, green: 241/255, blue: 247/255, alpha: 1.0)

        setupBackgroundView()
        setupWeatherCardView()
    
        setupLabels()
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

        cardGradient.colors = [
            UIColor.white.withAlphaComponent(0.15).cgColor,
            UIColor.white.withAlphaComponent(0.05).cgColor
        ]
        cardGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        cardGradient.endPoint = CGPoint(x: 1.0, y: 1.0)

        if cardGradient.superlayer == nil {
            weatherCardView.layer.insertSublayer(cardGradient, at: 0)
        }
    }

   

    func applyButtonShadow() {
        forecastButton.layer.shadowColor = UIColor.black.cgColor
        forecastButton.layer.shadowOpacity = 0.14
        forecastButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        forecastButton.layer.shadowRadius = 12
    }

    func setupLabels() {
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.96)
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        dateLabel.textAlignment = .center

    
        tempLabel.font = UIFont.systemFont(ofSize: 92, weight: .light)
        tempLabel.textAlignment = .center
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.minimumScaleFactor = 0.8

        conditionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        conditionLabel.textAlignment = .center
        conditionLabel.adjustsFontSizeToFitWidth = false
        conditionLabel.lineBreakMode = .byClipping

        windValueLabel.textColor = UIColor.white.withAlphaComponent(0.95)
        windValueLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        humidityValueLabel.textColor = UIColor.white.withAlphaComponent(0.95)
        humidityValueLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        applySoftShadow(to: dateLabel)
        applySoftShadow(to: tempLabel)
        applySoftShadow(to: conditionLabel)
        applySoftShadow(to: windValueLabel)
        applySoftShadow(to: humidityValueLabel)
    }

    func setupWeatherImage() {
        weatherImageView.contentMode = .scaleAspectFit
    }

    func applySoftShadow(to label: UILabel) {
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.14
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.layer.shadowRadius = 4
        label.layer.masksToBounds = false
    }

    func loadDummyData() {
        dateLabel.text = "Today, 12 September"
        tempLabel.text = "29°"
        conditionLabel.text = "Cloudy"
        windValueLabel.text = "10 km/h"
        humidityValueLabel.text = "54 %"
        weatherImageView.image = UIImage(named: "Group 650 (2)")
    }
}
