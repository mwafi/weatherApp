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
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
}
