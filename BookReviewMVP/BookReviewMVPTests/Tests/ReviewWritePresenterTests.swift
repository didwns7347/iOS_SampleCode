//
//  ReviewWritePresenterTests.swift
//  BookReviewMVPTests
//
//  Created by yangjs on 2023/04/28.
//

import XCTest
@testable import BookReviewMVP

class ReviewWritePresenterTests: XCTestCase {
    var sut: ReviewWritePresenter!
    var vc: MockReviewWriteVC!
    var userDefaultsManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        vc = MockReviewWriteVC()
        userDefaultsManager = MockUserDefaultsManager()
        sut = ReviewWritePresenter(viewcontroller: vc, reviewStorage: userDefaultsManager)
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        userDefaultsManager = nil
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될때() {
        sut.viewDidLoad()
        XCTAssertTrue(vc.isCalledsetupViews)
        XCTAssertTrue(vc.isCalledsetUpNavigtaionBar)
    }
    
    func test_didTapLeftBarButton가_호출될때() {
        sut.didLeftBarButtonTapped()
        XCTAssertTrue(vc.isCalledshowCloseAlertSheet)
    }
    
   
    
    func test_didRgihtBarButtonTapped가_호출될때_Book이_존재하고_ContentsTexte가_플레이스홀더와_같지않게_존재하면() {
        sut.book = Book(title:"Swift",imageURL:"")
        sut.didRightBarButtonTapped(contentText: "hello")
        XCTAssertTrue(userDefaultsManager.isSaveCalled)
        XCTAssertTrue(vc.isCalleddismissVC)
    }
    
    func test_didRgihtBarButtonTapped가_호출될때_Book이_존재하지않으면() {
        sut.book = nil
        sut.didRightBarButtonTapped(contentText: "hello")
        XCTAssertFalse(vc.isCalleddismissVC)
        XCTAssertFalse(userDefaultsManager.isSaveCalled)
    }
    
    func test_didTapBookTitleButton이_호출될때() {
        sut.didTapBookTitleButton()
        XCTAssertTrue(vc.isCalledpresentToSearchBookViewController)
    }
    
    
    
}
