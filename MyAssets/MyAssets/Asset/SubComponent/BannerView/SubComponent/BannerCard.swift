//
//  BannerCard.swift
//  MyAssets
//
//  Created by yangjs on 2022/05/29.
//

import SwiftUI

struct BannerCard: View {
    var banner:AssetBanner
    var body: some View {
        Color(banner.backgorundColor)
            .overlay{
                VStack{
                    Text(banner.title)
                        .font(.title)
                    Text(banner.description)
                        .font(.subheadline)
                }
            }
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", description:"추가된 공지사항을 확인하세요",backgorundColor: .red)
        BannerCard(banner: banner0)
    }
}
