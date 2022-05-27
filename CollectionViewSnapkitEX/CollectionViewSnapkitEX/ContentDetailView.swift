//
//  ContentDetailView.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/05/27.
//

import SwiftUI

struct ContentDetailView: View {
    @State var item :Item?
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .bottom){
                if let item = item {
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:200)
                    
                    Text(item.description)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.primary.colorInvert().opacity(0.75))
                    
                }else{
                    Color.white
                }
            }
        }
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item1 = Item(description: "흥미진지,판타지,애니메이션,액션", imageName: "poster0")
        ContentDetailView(item: item1)
    }
}
