//
//  AssetSummaryView.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/30.
//

import SwiftUI

struct AssetSummaryView: View {
    @EnvironmentObject var assetData:AssetSummaryData
    var assets:[Asset]{
        return assetData.assets
    }
    
    var body: some View {
        VStack(spacing:20){
            ForEach(assets){ asset in
                AssetSectionview(assetSedtion: asset)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
    }
}

struct AssetSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AssetSummaryView()
            .environmentObject(AssetSummaryData())
            .background(.gray.opacity(0.2))
    }
}
