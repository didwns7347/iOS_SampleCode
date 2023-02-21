//
//  HomeView.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        ScrollView(.vertical){
            HeaderView(isNeetToReload: $viewModel.isNeedToReload)
            MenuSuggestionSectionView(menu: $viewModel.coffeeMenu)
            Spacer(minLength: 32.0)
            EventsSectionView(events: $viewModel.events)
            
        }
    }
} 

struct HeaderView : View{
    @Binding var isNeetToReload : Bool
    
    var body: some View{
        VStack(spacing: 16){
            HStack(alignment:.top){
                Text("\(User.shared.username)님\n반갑습니다!☕️")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Button(action: {
                    isNeetToReload = true
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
            }
            
            HStack{
                Button(action: {}) {
                    HStack{
                        Image(systemName: "newspaper")
                            .foregroundColor(.secondary)
                        Text("What's New")
                            .font(.system(size: 16, weight: .semibold,design: .default))
                            .foregroundColor(.black)
                    }
                }
                Button(action: {}) {
                    Image(systemName: "ticket")
                        .foregroundColor(.secondary)
                    Text("Coupon")
                        .font(.system(size: 16, weight: .semibold,design: .default))
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "bell")
                }
            }
        }.padding(16)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
