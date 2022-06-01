//
//  AssetSectionHeaderview.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/30.
//

import SwiftUI

struct AssetSectionHeaderview: View {
    let title:String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.accentColor)
            Divider()
                .frame(height: 2)
                .background(Color.primary)
                .foregroundColor(.accentColor)
        }
    }
}

struct AssetSectionHeaderview_Previews: PreviewProvider {
    static var previews: some View {
        AssetSectionHeaderview(title: "은행")
    }
}
