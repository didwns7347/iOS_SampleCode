//
//  User.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import Foundation

struct User{
    let username :String
    let account : String
    
    static let shared = User(username: "못말리는짱구", account: "yangjs")
}
