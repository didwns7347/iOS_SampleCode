//
//  Content.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/04/18.
//

import UIKit

struct Content: Decodable{
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    enum SectionType: String, Decodable{
        case basic
        case large
        case main
        case rank
    }
}
struct Item : Decodable{
    let description : String
    let imageName : String
    
    var image: UIImage{
        return UIImage(named: imageName) ?? UIImage()
    }
}
 
