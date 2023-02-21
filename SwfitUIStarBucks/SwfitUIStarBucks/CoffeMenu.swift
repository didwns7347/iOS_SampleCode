//
//  CoffeMenu.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI

struct CoffeMenu: Identifiable{
    let image : Image
    let name : String
    
    let id = UUID()
    
    static let sample: [CoffeMenu] = [
        CoffeMenu(image: Image("coffee"), name: "아메리카노"),
        CoffeMenu(image: Image("coffee"), name: "아이스 아메리카노"),
        CoffeMenu(image: Image("coffee"), name: "까페라떼"),
        CoffeMenu(image: Image("coffee"), name: "아이스 까페라떼"),
        CoffeMenu(image: Image("coffee"), name: "드립커피"),
        CoffeMenu(image: Image("coffee"), name: "아이스 드립커피")
    ]
    
}
