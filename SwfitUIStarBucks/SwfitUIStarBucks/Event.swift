//
//  Event.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI

struct Event : Identifiable{
    let id = UUID()
    
    let image : Image
    let title : String
    let description : String
    
    static let sample : [Event] = [
        Event(image: Image("coffee"), title: "제주도 한정 메뉴", description: "제주도 한정 음료가 출시되었습니다."),
        Event(image: Image("coffee"), title: "여름 한정 메뉴", description: "여름에는 아이스커피 여름에 맥심아이스."),
        Event(image: Image("coffee"), title: "서울 함정 메뉴", description: "서울도 함정 음료가 출시되었습니다.")
    ]
}
