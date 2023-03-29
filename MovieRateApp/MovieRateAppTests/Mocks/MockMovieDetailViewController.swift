//
//  MockMovieDetailViewController.swift
//  MovieRateAppTests
//
//  Created by yangjs on 2023/03/28.
//

import XCTest
@testable import MovieRateApp

final class MockMovieDetailViewController: MovieDetailProtocol{
    var isCalledSetViews = false
    var isCalledSetRightBarButton = false
    func setViews(with movie: MovieRateApp.Movie) {
        isCalledSetViews = true
    }
    
    func setRightBarButton(with isLiked: Bool) {
        isCalledSetRightBarButton = true
    }
}


