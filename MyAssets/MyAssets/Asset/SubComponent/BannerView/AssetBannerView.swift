//
//  AssetBannerView.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/29.
//

import SwiftUI

struct AssetBannerView: View {
    let bannerList : [AssetBanner] = [
        AssetBanner(title: "공지사항", description: "확인해라", backgorundColor: .red),
        AssetBanner(title: "진", description: "확인해라", backgorundColor: .blue),
        AssetBanner(title: "짜", description: "확인해라", backgorundColor: .gray),
        AssetBanner(title: "로", description: "확인해라", backgorundColor: .purple)
                    ]
    
    @State private var currentPage=0
    
    
    var body: some View {
        let bannerCard = bannerList.map{BannerCard(banner: $0)}
        
        ZStack(alignment: .bottomTrailing){
            PageViewController(pages: bannerCard, currentPage: $currentPage)
            PageControl(numberOfPage: bannerList.count, currentPage: $currentPage)
                .frame(width: CGFloat(bannerCard.count * 18))
                .padding(.trailing)
        }
    }
}

struct AssetBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AssetBannerView()
            .aspectRatio(5/2, contentMode: .fit)
    }
}
