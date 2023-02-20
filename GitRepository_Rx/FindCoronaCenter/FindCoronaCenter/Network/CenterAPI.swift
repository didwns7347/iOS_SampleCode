//
//  CenterAPI.swift
//  FindCoronaCenter
//
//  Created by yangjs on 2023/02/20.
//

import Foundation
import Combine

struct CenterAPI{
    static let scheme = "https"
    static let host = "api.odcloud.kr"
    static let path = "/api/15077586/v1/centers"
    
    func getCenterListComponents() -> URLComponents{
        var compoments = URLComponents()
        compoments.scheme = CenterAPI.scheme
        compoments.host = CenterAPI.host
        compoments.path = CenterAPI.path
        
        compoments.queryItems = [
            URLQueryItem(name: "perPage", value: "300")
        ]
        return compoments
    }
}
