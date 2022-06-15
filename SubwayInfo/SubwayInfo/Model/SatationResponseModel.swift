//
//  SatationResponseModel.swift
//  SubwayInfo
//
//  Created by yangjs on 2022/06/15.
//

import Foundation

struct StationResponseModel: Decodable{
    var stations: [Station]{
        searchInfo.row
    }
    private let searchInfo: SearchInfoBySubWayNameServiceModel
    enum CodingKeys : String, CodingKey{
         case searchInfo  = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubWayNameServiceModel: Decodable{
        var row: [Station] = []
    }
}
struct Station: Decodable{
    let stationName: String
    let lineNumber : String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
    
}
