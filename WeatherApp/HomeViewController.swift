//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 15/04/2026.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var cloudImageView: UIImageView!
    private let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    private func setupGradientBackground() {
        gradientLayer.colors = [
            UIColor(red: 71/255, green: 191/255, blue: 223/255, alpha: 1).cgColor,
            UIColor(red: 74/255, green: 145/255, blue: 255/255, alpha: 1).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
