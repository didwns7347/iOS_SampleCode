//
//  SwfitUIStarBucksApp.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI

@main
struct SwfitUIStarBucksApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .accentColor(.green)
        }
    }
}
//tintcolor -> accentcolor 로 변경됨.
