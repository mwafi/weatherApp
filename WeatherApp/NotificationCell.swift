//
//  NotificationCell.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 17/04/2026.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
