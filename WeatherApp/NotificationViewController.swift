//
//  NotificationViewController.swift.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 17/04/2026.
//

import Foundation
import UIKit
class NotificationViewController:UIViewController
{
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var overlayView: UIVisualEffectView!
    override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = .clear
             sheetView.layer.cornerRadius = 30
             sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
             sheetView.clipsToBounds = true

            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissScreen))
            overlayView.addGestureRecognizer(tap)
        }

        @objc func dismissScreen() {
            dismiss(animated: true)
        }
}
