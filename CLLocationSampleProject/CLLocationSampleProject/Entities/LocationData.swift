//
//  LocationData.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/19.
//

import Foundation

struct LocationData : Decodable{
    let documents:[KLDocument ]
}

struct KLDocument: Decodable {
    let placeName: String
    let addressName: String
    let roadAddressName: String
    let x: String
    let y: String
    let distance: String
    
    enum CodingKeys: String, CodingKey {
        case x, y, distance
        case placeName = "place_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
    }
}

struct DetailListCellData{
    let placeName : String
    let roadAddressName : String
    let distance : String
    let point : MTMapPoint
//    init(doc : KLDocument) {
//        self.distance = doc.distance + "M"
//        self.placeName = doc.placeName
//        self.roadAddressName = doc.roadAddressName
//    }
}

/*
{
    "documents":[
        {
            "address_name": "서울 강남구 삼성동 160-22",
            "category_group_code": "CS2",
            "category_group_name": "편의점",
            "category_name": "가정,생활 > 편의점 > 이마트24",
            "distance": "125",
            "id": "1234581626",
            "phone": "02-6916-1500",
            "place_name": "이마트24 SMART삼성S&J빌딩점",
            "place_url": "http://place.map.kakao.com/1234581626",
            "road_address_name": "서울 강남구 영동대로106길 9",
            "x": "127.061848545457",
            "y": "37.5135085833768"
        },
        {"address_name": "서울 강남구 삼성동 162-5", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > CU",…},
        {"address_name": "서울 강남구 삼성동 109-2", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > CU",…},
        {"address_name": "서울 강남구 삼성동 165-10", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > GS25",…},
        {"address_name": "서울 강남구 삼성동 106-6", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > 씨스페이스",…},
        {"address_name": "서울 강남구 삼성동 162-13", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > 세븐일레븐",…},
        {"address_name": "서울 강남구 삼성동 111-8", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > GS25",…},
        {"address_name": "서울 강남구 삼성동 163-3", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > 이마트24",…},
        {"address_name": "서울 강남구 삼성동 168", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > GS25",…},
        {"address_name": "서울 강남구 삼성동 77-23", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > GS25",…},
        {"address_name": "서울 강남구 삼성동 90-18", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > CU",…},
        {"address_name": "서울 강남구 삼성동 92-7", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > 이마트24",…},
        {"address_name": "서울 강남구 삼성동 159", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > 세븐일레븐",…},
        {"address_name": "서울 강남구 삼성동 159", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > 이마트24",…},
        {"address_name": "서울 강남구 삼성동 159", "category_group_code": "CS2", "category_group_name": "편의점", "category_name": "가정,생활 > 편의점 > 이마트24",…}
    ],
    "meta":{
        "is_end": false,
        "pageable_count": 45,
        "same_name":{
            "keyword": "편의점",
            "region":[],
            "selected_region": ""
        },
        "total_count": 11953
    }
}
*/
