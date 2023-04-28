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
        userDefaultManager = nil
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


