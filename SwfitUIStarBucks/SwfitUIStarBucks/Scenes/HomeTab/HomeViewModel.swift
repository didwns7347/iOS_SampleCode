//
//  HomeViewModel.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI
class HomeViewModel : ObservableObject{
    @Published var isNeedToReload = false {
        didSet{
            guard isNeedToReload else { return }
            coffeeMenu.shuffle()
            events.shuffle()
            isNeedToReload = false
            
        }
    }
    
    
    @Published var coffeeMenu: [CoffeMenu] = [
        CoffeMenu(image: Image("coffee"), name: "아메리카노"),
        CoffeMenu(image: Image("coffee"), name: "아이스 아메리카노"),
        CoffeMenu(image: Image("coffee"), name: "까페라떼"),
        CoffeMenu(image: Image("coffee"), name: "아이스 까페라떼"),
        CoffeMenu(image: Image("coffee"), name: "드립커피"),
        CoffeMenu(image: Image("coffee"), name: "아이스 드립커피")
    ]
    
    @Published var events : [Event] = [
        Event(image: Image("coffee"), title: "제주도 한정 메뉴", description: "제주도 한정 음료가 출시되었습니다."),
        Event(image: Image("coffee"), title: "여름 한정 메뉴", description: "여름에는 아이스커피 여름에 맥심아이스."),
        Event(image: Image("coffee"), title: "서울 함정 메뉴", description: "서울도 함정 음료가 출시되었습니다.")
    ]
    
}
