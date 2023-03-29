//
//  MovieDetailPresenterTests.swift
//  MovieRateAppTests
//
//  Created by yangjs on 2023/03/28.
//

import XCTest

@testable import MovieRateApp

class MovieDetailPresenterTests: XCTestCase {
    var sut: MovieDetailPresenter!
    var movie: Movie!
    var vc: MockMovieDetailViewController!
    var userDefaultsManager: MockUserDefaultManager!
    
    
    override func setUp() {
        super.setUp()
        
        vc = MockMovieDetailViewController()
        userDefaultsManager = MockUserDefaultManager()
        movie = Movie(title: "", imageURL: "", userRating: "", actor: "", director: "", pubDate: "")
        
        sut = MovieDetailPresenter(
            viewcontroller: vc,
            movie: movie,
            userDefaultManager: userDefaultsManager
        )
    }
    
    override func tearDown() {
        sut = nil
        
        vc = nil
        userDefaultsManager = nil
        movie = nil
        super.tearDown()
    }
    
    func test_viewDidLoad가_실행되면() {
        sut.viewDidLoad()
        XCTAssertTrue(vc.isCalledSetViews)
        XCTAssertTrue(vc.isCalledSetRightBarButton)
    }
    
    // isLiked true
    func test_didTapRightBarButtonItem이_호출될때_isLiked가_true가되면() {
        movie.isLiked = false

        sut = MovieDetailPresenter(
            viewcontroller: vc,
            movie: movie,
            userDefaultManager: userDefaultsManager
        )

        sut.didTapRightBarButtonTapped()

        XCTAssertTrue(userDefaultsManager.isCalledAddMovies)
        XCTAssertFalse(userDefaultsManager.isCalledRemoveMovie)

        XCTAssertTrue(vc.isCalledSetRightBarButton)
    }

    // isLiked false
    func test_didTapRightBarButtonItem이_호출될때_isLiked가_false가되면() {
        movie.isLiked = true

        sut = MovieDetailPresenter(
            viewcontroller: vc,
            movie: movie,
            userDefaultManager: userDefaultsManager
        )

        sut.didTapRightBarButtonTapped()

        XCTAssertFalse(userDefaultsManager.isCalledAddMovies)
        XCTAssertTrue(userDefaultsManager.isCalledRemoveMovie)

        XCTAssertTrue(vc.isCalledSetRightBarButton)
    }
    
}
