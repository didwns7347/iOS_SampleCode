//
//  AssetMenuButtonStyle.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/29.
//

import SwiftUI

struct AssetMenuButtonStyle: ButtonStyle {
    let menu : AssetMenu
    func makeBody(configuration: Configuration) -> some View {
        return VStack{
            Image(systemName: menu.systemImageName)
                .resizable()
                .frame(width:30,height: 30)
                .padding([.leading,.trailing],10)
            Text(menu.title)
                //.frame(width: 50, height: 30)
                .font(.system(size: 12,weight: .bold))
        }.padding()
            .foregroundColor(.blue)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct AssetMenuButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing:24){
            Button(""){
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .creditScore))
            Button(""){
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .creditCard))
            Button(""){ 
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .realEstate))
            Button(""){
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .loan))
            Button(""){
                print("")
            }
        }.background(Color.gray.opacity(0.2))
    }
}
