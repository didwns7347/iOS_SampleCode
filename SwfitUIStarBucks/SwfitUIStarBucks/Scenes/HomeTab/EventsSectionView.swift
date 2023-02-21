//
//  EventsSectionView.swift
//  SwfitUIStarBucks
//
//  Created by yangjs on 2023/02/21.
//

import SwiftUI

struct EventsSectionView: View {
    @Binding var events : [Event]
    var body: some View {
        VStack{
            HStack{
                Text("Events")
                    .font(.headline)
                Spacer()
                Button(action: {}) {
                    Text("See all")
                        .font(.headline)
                }
                
            }.padding(16)
            
            ScrollView(.horizontal ,showsIndicators: false){
                LazyHStack(spacing:16){
                    ForEach(events){ event in
                        EventSectionItemView(event:  event)
                    }
                }
                .frame(maxWidth: .infinity,minHeight: 220, maxHeight: .infinity)
                .padding(.horizontal,16)
                
            }
        }
    }
}

struct EventSectionItemView : View{
    let event : Event
    var body: some View{
        VStack{
            event.image
                .resizable()
                .scaledToFill()
                .frame(height:150)
                .clipped()
            Text(event.title)
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.headline)
            Text(event.description)
                .lineLimit(1)
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
        }.frame(width: UIScreen.main.bounds.width - 32.0)
    }
}

//struct EventsSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsSectionView()
//    }
//}
