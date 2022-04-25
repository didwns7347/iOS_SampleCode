//
//  AlertListTableViewCell.swift
//  CH04localNotification
//
//  Created by yangjs on 2022/04/04.
//

import UIKit
import UserNotifications

class AlertListTableViewCell: UITableViewCell {
    let userNotificationCenter = UNUserNotificationCenter.current()
    @IBOutlet weak var switchLabel: UISwitch!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var meridiemLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchBtnTabbled(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return }
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        
        if sender.isOn{
            userNotificationCenter.addNotificatoinRequest(by: alerts[sender.tag])
        }else{
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])

        }
    }
}
