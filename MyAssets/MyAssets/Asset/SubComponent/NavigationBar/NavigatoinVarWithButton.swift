//
//  NavigatoinVarWithButton.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/27.
//

import SwiftUI

struct NavigatoinVarWithButton: ViewModifier {
    var title:String = ""
    func body(content: Content) -> some View {
        return content
            .navigationBarItems(
                leading:  Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                ,
                
                trailing: Button(
                    action:{
                        print("자산 추가버튼 tapped")
                    },
                    label: {
                        Image(systemName: "plus")
                        Text("자산추가")
                            .font(.system(size: 12))
                    }
                ).accentColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8 ))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black))
            ).navigationBarTitleDisplayMode(.inline)
            .onAppear{
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = UIColor(white: 1, alpha: 0.5)
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
    }
}
extension View{
    func navigaionBarWithButtonStyle(_ title:String)-> some View{
        return self.modifier(NavigatoinVarWithButton(title: title))
    }
}
struct NavigatoinVarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Color.gray.edgesIgnoringSafeArea(.all)
                .navigaionBarWithButtonStyle("내 자산")
            
                
        }

    }
}
