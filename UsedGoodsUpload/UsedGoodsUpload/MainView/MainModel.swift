//
//  MainModel.swift
//  UsedGoodsUpload
//
//  Created by yangjs on 2022/07/28.
//

import Foundation

struct MainModel{
    func setAlert(errorMessage:[String])->(title:String, message:String?){
        let title = errorMessage.isEmpty ? "성공":"실패"
        let message = errorMessage.isEmpty ? nil:errorMessage.joined(separator: "\n")
        return (title:title, message:message)
    }
}
