//
//  NotificationViewController.swift.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 17/04/2026.
//

import Foundation
import UIKit
struct NotificationItem {
    let message: String
    let time: String
    let iconName: String
}
class NotificationViewController:UIViewController,UITableViewDelegate, UITableViewDataSource
{
    let newNotifications = [
        NotificationItem(
            message: "A sunny day in your location",
            time: "10 minutes ago",
            iconName: "sun.max.fill"
        )
    ]

    let earlierNotifications = [
        NotificationItem(
            message: "A cloudy day will occur all day long،A sunny day in your location،A sunny day in your location",
            time: "1 day ago",
            iconName: "wind"
        ),
        NotificationItem(
            message: "Potential for rain today is 84%",
            time: "2 days ago",
            iconName: "cloud.rain"
        )
    ]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? newNotifications.count : earlierNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell

        let item = indexPath.section == 0
            ? newNotifications[indexPath.row]
            : earlierNotifications[indexPath.row]

        cell.messageLabel.text = item.message
        cell.timeLabel.text = item.time
        cell.statusIcon.image = UIImage(systemName: item.iconName)

        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "New" : "Earlier"
    }
    
    @IBOutlet weak var tableView: UITableView!
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
        overlayView.isUserInteractionEnabled = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.backgroundColor = .clear

        sheetView.backgroundColor = .white
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

        @objc func dismissScreen() {
            dismiss(animated: true)
        }
}
