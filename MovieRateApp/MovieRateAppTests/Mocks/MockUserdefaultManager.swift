//
//  MockUserdefaultManager.swift
//  MovieRateAppTests
//
//  Created by yangjs on 2023/03/28.
//

import XCTest
@testable import MovieRateApp
final class MockUserDefaultManager: UserDefaultManegerProtocol {
    var isCalledGetMovies = false
    var isCalledAddMovies = false
    var isCalledRemoveMovie = false
    func getMovies() -> [MovieRateApp.Movie] {
        isCalledGetMovies = true
        return []
    }
    
    func addMovies(_ newValue: MovieRateApp.Movie) {
        isCalledAddMovies = true
    }
    
    func removeMovie(_ value: MovieRateApp.Movie) {
        isCalledRemoveMovie = true
    }
    
    
}
