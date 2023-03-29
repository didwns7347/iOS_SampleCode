//
//  MovieListPresenterTests.swift
//  MovieRateAppTests
//
//  Created by yangjs on 2023/03/28.
//

import XCTest

@testable import MovieRateApp

class MovieListPresenterTests: XCTestCase {
    var sut: MovieListPresenter!
    
    var viewContoller: MockMovieListViewController!
    var userDefultsManager: MockUserDefaultManager!
    var movieSearchManager: MockMovieSearchManager!
    
    override func setUp() {
        super.setUp()
        
        viewContoller = MockMovieListViewController()
        userDefultsManager = MockUserDefaultManager()
        movieSearchManager = MockMovieSearchManager()
        
        sut = MovieListPresenter(
            viewcontroller: viewContoller,
            movieSearchManager: movieSearchManager, userDefaultManager: userDefultsManager
        )
    }
    
    override func tearDown() {
        sut = nil
        
        viewContoller = nil
        userDefultsManager = nil
        movieSearchManager = nil
        super.tearDown()
    }
    
    // request메소드가 성공하면 updateSearchTableView가 실행되고
    func test_searchBar_textDidChange가_호출될때_request가_성공하면() {
        movieSearchManager.needToSuccessRequest = true
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertTrue(viewContoller.isCalledUpdateSearchTableView, "updateSearchTableView가 실행된다.")
    }
    // request메소드가 실패하면 updateSearchTableView가 실행되지 않겠죠?
    func test_searchBar_textDidChange가_호출될때_request가_실패하면() {
        movieSearchManager.needToSuccessRequest = false
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertFalse(viewContoller.isCalledUpdateCollectionView, "updateSearchTableView가 실행되지 않는다.")
    }
    
    func test_viewDidLoad가_호출되면() {
        sut.viewDidLoad()
        XCTAssertTrue(viewContoller.isCalledSetupNavigationBar)
        XCTAssertTrue(viewContoller.isCalledSetupSearchBar)
        XCTAssertTrue(viewContoller.isCalledSetupViews)
    }
    func test_viewWillApper가_호출되면() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefultsManager.isCalledGetMovies)
        XCTAssertTrue(viewContoller.isCalledUpdateCollectionView)
        
    }
    
    func test_searchBarTextDidBeginEditing이_호출되면() {
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        XCTAssertTrue(viewContoller.isCalledUpdateSearchTableView)
    }
    
    func test_searchBarCancelButtonClicked이_호출되면() {
        sut.searchBarCancelButtonClicked(UISearchBar())
        
        XCTAssertTrue(viewContoller.isCalledUpdateSearchTableView)
    }
}
