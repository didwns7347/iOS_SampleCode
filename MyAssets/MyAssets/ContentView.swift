//
//  ContentView.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/27.
//

import SwiftUI

struct ContentView: View {
    @State private var selection:Tab = .asset
    
    enum Tab{
        case asset
        case recommand
        case alert
        case setting
    }
    var body: some View {
        TabView(selection: $selection) {
            Color.white
                .tabItem{
                    Image(systemName:"dollarsign.circle.fill")
                    Text("자산")
                }
                .tag(Tab.asset)
            Color.blue.tabItem {
                Image(systemName: "hand.thumbsup.fill")
                Text("추천")
            }.tag(Tab.recommand)
            
            Color.yellow.tabItem {
                Image(systemName: "bell.fill")
                Text("알람")
            }.tag(Tab.alert)
            
            Color.green.tabItem {
                Image(systemName: "gearshape.fill")
                Text("설정")
            }.tag(Tab.setting)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
