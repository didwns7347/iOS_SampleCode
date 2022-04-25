//
//  AlertListViewConroller.swift
//  CH04localNotification
//
//  Created by yangjs on 2022/04/04.
//

import UIKit
import UserNotifications

class AlertListViewConroller:UITableViewController{
    var alertList :[Alert] = []
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "AlertListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alertList = self.getAlertList()
    }
    
    @IBAction func addAlertActionBtn(_ sender: Any) {
        guard let adAlertVC = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else {return}
    
        adAlertVC.pickedDate = {[weak self] date in
            guard let self = self else {return}
            var alertList = self.getAlertList()
            let newAlert = Alert(date: date, isOn: true)
            alertList.append(newAlert)
            alertList.sort {$0.date<$1.date}
            
            self.alertList = alertList
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(alertList), forKey: "alerts")
            self.userNotificationCenter.addNotificatoinRequest(by: newAlert)
            
            self.tableView.reloadData()
        }
        self.present(adAlertVC, animated: true, completion: nil)
    }
    
    func getAlertList()->[Alert]{
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else{ return []}
        return alerts
    }

}

//UITableViewdata Source delegate
extension AlertListViewConroller{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertList.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "물마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListTableViewCell",for:indexPath) as? AlertListTableViewCell else {return UITableViewCell()}
        cell.switchLabel.isOn = alertList[indexPath.row].isOn
        cell.timeLabel.text = alertList[indexPath.row].time
        cell.meridiemLabel.text = alertList[indexPath.row].meridiem
        
        cell.switchLabel.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case.delete:
            //노티피케이션 삭제
            self.alertList.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alertList), forKey: "alerts")
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [self.alertList[indexPath.row].id])
            
            self.tableView.reloadData()
            return
        default:
            break
        }
    }
}
