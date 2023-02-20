//
//  CenterList.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import SwiftUI

struct CenterList: View {
    var centers = [Center]()
    
    var body: some View {
        List(centers,id: \.id) { center in
            NavigationLink(destination: CenterDetailView(center: center)) {
                CenterRow(center: center)
            }
        }
//
    }
}

struct CenterList_Previews: PreviewProvider {
    static var previews: some View {
        let centers = [
            Center(id: 0, sido: .경기도, facilityName: "실내빙상장 옆", address: "경기도 특장 모모구", lat: "37.404476", lng: "126.949998", centerType: .central, phoneNumber: "010-0000-0000"),
            Center(id: 1, sido: .경기도, facilityName: "실내빙상장 옆1", address: "경기도 특장 모모구", lat: "37.404476", lng: "126.949998", centerType: .central, phoneNumber: "010-0000-0000"),
            Center(id: 2, sido: .경기도, facilityName: "실내빙상장 옆2", address: "경기도 특장 모모구", lat: "37.404476", lng: "126.949998", centerType: .central, phoneNumber: "010-0000-0000")
        ]
        CenterList(centers: centers)
    }
}
