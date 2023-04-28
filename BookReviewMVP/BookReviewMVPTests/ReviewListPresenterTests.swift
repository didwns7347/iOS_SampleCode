//
//  BookReviewMVPTests.swift
//  BookReviewMVPTests
//
//  Created by 양준수 on 2023/04/12.
//

import XCTest
@testable import BookReviewMVP

final class ReviewListPresenterTests: XCTestCase {
    var sut: ReviewListPresenter! //sut으로 많이 호칭됨.
    var viewController : MockReviewListViewController!
    var userDefaultManager : MockUserDefaultsManager!
    override func setUp() {
        super.setUp()
        viewController = MockReviewListViewController()
        userDefaultManager = MockUserDefaultsManager()
        sut = ReviewListPresenter(
            vc: viewController,
            storageManager: userDefaultManager
        )
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될때() {
        sut.viewDidLoad()
        XCTAssertTrue(viewController.isCalledSetUpViews)
        XCTAssertTrue(viewController.isCalledSetUpNavigationBar)
    }
    
    func test_viewWillAppear가_호출될때() {
        sut.viewWillAppear()
        XCTAssertTrue(viewController.isCalledReloadTableView)
        XCTAssertTrue(userDefaultManager.isFetchCalled)
    }
    
    func test_didTapRightBarButtonItem이_호출될때() {
        sut.didRightBarButtonTapped()
        XCTAssertTrue(viewController.isCalledpresentReviewWriteVC)
    }
}


//원하는 타이밍에 메소드가 호출되는지 확인하는 뷰컨트롤러
final class MockReviewListViewController : ReviewListProtocol {
    var isCalledSetUpNavigationBar = false
    var isCalledSetUpViews = false
    var isCalledpresentReviewWriteVC = false
    var isCalledReloadTableView = false
    
    //true로바꼈으면 호출된것으로 테스트를 확인한다.
    func setUpNavigationBar() {
        isCalledSetUpNavigationBar = true
    }
    
    func setUpViews() {
        isCalledSetUpViews = true
    }
    
    func presentReviewWriteVC() {
        isCalledpresentReviewWriteVC = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    
    
}

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
