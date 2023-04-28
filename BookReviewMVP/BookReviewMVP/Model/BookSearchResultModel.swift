//
//  BookSearchResultModel.swift
//  BookReviewMVP
//
//  Created by yangjs on 2023/04/27.
//

import Foundation
import UIKit
struct BookSearchRequestModel: Codable {
    ///검색할 책 키워드
    let query : String
}
struct BookSearchResponseModel: Decodable {
    var items: [Book] = []
}
struct Book: Decodable {
    let title: String
    private let image: String?
    
    var imageURL: URL? { URL(string: self.image ?? "")}
    
    init(title: String, imageURL: String?) {
        self.title = title
        self.image = imageURL
    }
}


struct BookReview :Codable {
    var title: String?
    var conent: String?
    var thumbnail: URL?
}
