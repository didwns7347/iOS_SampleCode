//
//  SearchBookPresenterTests.swift
//  BookReviewMVPTests
//
//  Created by yangjs on 2023/04/28.
//

import XCTest
@testable import BookReviewMVP

class SearchBookPresenterTests: XCTest {
    var vc :MockSearchBookVC!
    var sut :SearchBookViewPresenter!
    var isCalledBookSearchDelegate :Bool!
    
    override func setUp() {
        vc = MockSearchBookVC()
        sut = SearchBookViewPresenter(vc: vc, bookSearckDelegate: self)
        isCalledBookSearchDelegate = false
        
    }
    
    override func tearDown() {
        vc = nil
        sut = nil
        isCalledBookSearchDelegate = false
    }
    
    func test_viewDidload가_호출되면() {
        sut.viewDidload()
        
        XCTAssertTrue(vc.isCalledSetupViews)
    }
    
    func test_searchBarSearchButtonClicked가_호출되면() {
        sut.searchBarSearchButtonClicked(UISearchBar())
    }
}
extension SearchBookPresenterTests : BookSearchDelegate {
    func bookDidSelected(book: BookReviewMVP.Book) {
        self.isCalledBookSearchDelegate = true
    }
    
    
}
