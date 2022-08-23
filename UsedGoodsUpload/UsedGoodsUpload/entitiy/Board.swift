//
//  Board.swift
//  UsedGoodsUpload
//
//  Created by yangjs on 2022/08/17.
//

import Foundation
struct Board {
    var title : String
    var categoary: String
    var price : String?
    var content : String
    var createDate : Date
    
    init(title:String, category:String, price:String? = nil, content:String){
        self.title = title
        self.price = price ?? "??"
        self.content = content
        self.categoary = category
        self.createDate = Date()
    }
    
}
