//
//  SelectRegionItem.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import SwiftUI

struct SelectRegionItem: View {
    var region : Center.Sido
    var count : Int
    
    var body: some View {
        ZStack{
            Color(white: 0.9)
            VStack{
                Text("\(region.rawValue)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                
                Text("(\(count))")
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SelectRegionItem_Previews: PreviewProvider {
    static var previews: some View {
        let region = Center.Sido.서울특별시
        let count = 20
        SelectRegionItem(region: region, count: count)
    }
}
