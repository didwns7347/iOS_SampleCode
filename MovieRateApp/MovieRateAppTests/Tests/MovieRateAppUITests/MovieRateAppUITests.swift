//
//  MovieRateAppUITests.swift
//  MovieRateAppUITests
//
//  Created by yangjs on 2023/03/27.
//

import XCTest

class MovieRateAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // 실패하면 테스트종료
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
    }
    
    func test_navigationBar의_title이_영화평점으로_설정되어있다() {
        let existNavigationBar = app.navigationBars["영화 평점"].exists
        XCTAssertTrue(existNavigationBar)
    }
    
    func test_searchBar가_존재한다() {
        let existSearchBar = app.navigationBars["영화 평점"]
            .searchFields["Search"]
            .exists
        XCTAssertTrue(existSearchBar)
    }
    
    func test_searchBar의_cancel버튼이_존재한다() {
        let navigationBar = app.navigationBars["영화 평점"]
        navigationBar
            .searchFields["Search"]
            .tap()
        
        let existSearchBarCancelButton = navigationBar
            .buttons["Cancel"]
            .exists
        XCTAssertTrue(existSearchBarCancelButton)
    }
    
    func test_test() {

        
    }
    
    // BDD
    func test_영화가_즐겨찾기_되어있으면 () {
        let existCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: "킹스 도터")
            .element
            .exists
        
        XCTAssertTrue(existCell, "title이 표시된 셀티 존재한다.")
    }
    
    // BDD
    func test_영화가_즐겨찾기_되어있지_않으면 () {
        let existCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: "애니메이션의 모든 것")
            .element
            .exists
        
        XCTAssertFalse(existCell, "title이 표시된 셀티 존재한다.")
    }
}
