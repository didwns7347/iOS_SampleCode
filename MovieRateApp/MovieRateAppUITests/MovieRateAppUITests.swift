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
        //실패하면 테스트종료
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
    }
}
