//
//  StationArrivalDataResponseModel.swift
//  SubwayInfo
//
//  Created by yangjs on 2022/06/15.
//

import Foundation


struct StationArrivalDataResponseModel :Decodable{
    var realtimeArrivalList : [RealTimeArrival] = []
    
    struct RealTimeArrival: Decodable{
        let line: String
        let remainTime: String
        let currentStation: String
        
        enum CodingKeys : String, CodingKey{
            case line = "trainLineNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}
