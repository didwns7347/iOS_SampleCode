//
//  MenuSuggestionSectionView.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI

struct MenuSuggestionSectionView: View {
    @Binding var menu : [CoffeMenu]
    var body: some View {
        VStack{
            Text("\(User.shared.username)을 위한 추천메뉴")
                .font(.headline)
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding(16)

            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                    ForEach(menu){ menu in
                        MenuSuggestionItemView(item:menu)
                    }
                }.padding(.horizontal, 16)
            }
            
        }.frame(maxHeight:200)
            
    }
}
struct MenuSuggestionItemView : View{
    let item : CoffeMenu
    var body: some View{
        VStack(alignment:.center){
            item.image.resizable().frame(maxWidth: 100, maxHeight: 100).clipShape(Circle())
            Text("\(item.name)")
                .font(.caption)
        }
    }
}
//struct MenuSuggestionSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuSuggestionSectionView()
//    }
//}
