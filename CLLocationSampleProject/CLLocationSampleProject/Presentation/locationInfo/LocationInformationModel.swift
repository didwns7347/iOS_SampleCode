//
//  LocationInformationModel.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/22.
//

import Foundation
import RxSwift

struct LocationInformationModel{
    var localNetwork : LocalNetwork
    
    init(locationNetwork: LocalNetwork = LocalNetwork())
    {
        self.localNetwork = locationNetwork
    }
    
    func getLocation(by mapPoint:MTMapPoint) -> Single<Result<LocationData,URLError>>{
        return localNetwork.getLocation(by: mapPoint)
    }
    
    func docmuentsToCellData(_ data : [KLDocument]) -> [DetailListCellData]{
        return data.map{
            let address = $0.roadAddressName.isEmpty ? $0.addressName : $0.roadAddressName
            let point = documentToMTMapPoint($0)
            return DetailListCellData(placeName: $0.placeName, roadAddressName: address, distance: $0.distance, point: point)
        }
    }
    
    func documentToMTMapPoint(_ doc:KLDocument) -> MTMapPoint{
        let longtitude = Double(doc.x) ?? .zero
        let latitude = Double(doc.y) ?? .zero
        
        return MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longtitude))
    }
//    
//    func documentToMTMapPoint(_ doc: KLDocument) -> MTMapPoint {
//        let longitude = Double(doc.x) ?? .zero
//        let latitude = Double(doc.y) ?? .zero
//        
//        return MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude))
//    }
}
