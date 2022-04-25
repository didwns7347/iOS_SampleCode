//
//  UNNotificationCenter.swift
//  CH04localNotification
//
//  Created by yangjs on 2022/04/04.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter{
    func addNotificatoinRequest(by alert : Alert){
        let content = UNMutableNotificationContent()
        content.title = "물마실 시간입니다."
        content.body = "세계보건기구(WHO)가 권장하는 하루 물 섭취량은 1.5~2리터 입니다"
        content.sound = .default
        content.badge = 1
        let component = Calendar.current.dateComponents([.hour,.minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        
        self.add(request,withCompletionHandler: nil)
    }
}
