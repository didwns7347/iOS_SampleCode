//
//  Alert.swift
//  CH04localNotification
//
//  Created by yangjs on 2022/04/04.
//

import Foundation

struct Alert:Codable{
    var id:String = UUID().uuidString
    var date:Date
    var isOn:Bool
    
    var time: String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat="hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem:String{
        let formmater = DateFormatter()
        formmater.dateFormat="a"
        formmater.locale = Locale(identifier: "ko")
        return formmater.string(from: date)
    }
}
