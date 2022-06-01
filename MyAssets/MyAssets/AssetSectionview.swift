//
//  AssetSectionview.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/30.
//

import SwiftUI

struct AssetSectionview: View {
    @ObservedObject var assetSedtion:Asset
    
    var body: some View {
        VStack(spacing:20){
            AssetSectionHeaderview(title: assetSedtion.type.title)
            ForEach(assetSedtion.data){ asset in
                HStack{
                    Text(asset.title).font(.title).foregroundColor(.secondary)
                    Spacer()
                    Text(asset.amount).font(.title2).foregroundColor(.primary)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct AssetSectionview_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset(id: 0, type: .bankAccount, data: [AssetData(id: 0, title: "국민은행", amount: "5000000원"),AssetData(id: 0, title: "신한은행", amount: "5000000원"),AssetData(id: 0, title: "우리은행", amount: "5000000원")])
        AssetSectionview(assetSedtion:asset)
    }
}
