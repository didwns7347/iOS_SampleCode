//
//  LocationAPI.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/21.
//

import Foundation

struct localAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/local/search/category.json"
    /*
     https://dapi.kakao.com/v2/local/search/keyword.json?y=37.514322572335935&x=127.06283102249932&radius=20000&query=편의점
     https://dapi.kakao.com/v2/local/search/keyword.json?category_group_code=CS2&x=127.11034217349726&y=37.39425483521509&radius=500&sort=distance
     https://dapi.kakao.com/v2/local/search/keyword.json?y=37.514322572335935&x=127.06283102249932&radius=20000&query=%ED%8E%B8%EC%9D%98%EC%A0%90
     */
    func getLocation(by mapPoint: MTMapPoint) -> URLComponents{
        var components = URLComponents()
        components.scheme = localAPI.scheme
        components.host = localAPI.host
        components.path = localAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "category_group_code", value: "CS2"),
            URLQueryItem(name: "x", value: "\(mapPoint.mapPointGeo().longitude)"),
            URLQueryItem(name: "y", value: "\(mapPoint.mapPointGeo().latitude)"),
            URLQueryItem(name: "radius", value: "500"),
            URLQueryItem(name: "sort", value: "distance")
        ]
        
        
        return components
    }
}
