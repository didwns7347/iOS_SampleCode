//
//  UserDefaultManager.swift
//  BookReviewMVP
//
//  Created by yangjs on 2023/04/27.
//

import Foundation
protocol UserDefaultsManagerProtocol {
    func fetch() -> [BookReview]
    func save(book: BookReview)
}

struct BookStorageManager :UserDefaultsManagerProtocol {
    private let key = "bookreviews"
    ///북 저장
    func save(book:BookReview){
        var books = fetch()
        books.append(book)
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(books){
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
    }
    ///북 가져오기
    func fetch() -> [BookReview] {
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([BookReview].self, from: savedData) {
                return savedObject
            }
        }
        return []
    }
}
