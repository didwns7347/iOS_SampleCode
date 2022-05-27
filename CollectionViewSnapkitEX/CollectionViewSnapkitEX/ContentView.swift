//
//  ContentView.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/05/27.
//

import SwiftUI

struct ContentView: View {
    let titles = ["Netfilex Sampe App"]
    var body: some View {
        NavigationView{
            List(titles,id: \.self){
                let netfilxVC = HomeViewControllerRepresentable().navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                NavigationLink($0, destination: netfilxVC)
            } 
            .navigationTitle("SwiftUI to UIkit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
