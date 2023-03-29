//
//  MockMovieSearchManager.swift
//  MovieRateAppUITests
//
//  Created by yangjs on 2023/03/28.
//
import XCTest
@testable import MovieRateApp
final class MockMovieSearchManager: MoviewSearchManageable {
    var isCalledRequest = false
    
    var needToSuccessRequest = false
    
    func request(
        form keyword: String,
        completionHandler: @escaping (([MovieRateApp.Movie]) -> Void)
    ) {
        isCalledRequest = true
        
        if needToSuccessRequest {
            completionHandler([])
        }
    }
    
    
}
