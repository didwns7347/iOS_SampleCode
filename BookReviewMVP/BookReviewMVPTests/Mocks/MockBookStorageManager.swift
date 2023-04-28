//
//  MockBookStorageManager.swift
//  BookReviewMVPTests
//
//  Created by yangjs on 2023/04/28.
//

import Foundation
@testable import BookReviewMVP
final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var isFetchCalled = false
    var isSaveCalled = false
    func fetch() -> [BookReviewMVP.BookReview] {
        isFetchCalled = true
        
        return []
    }
    
    func save(book: BookReviewMVP.BookReview) {
        isSaveCalled = true
    }


}
