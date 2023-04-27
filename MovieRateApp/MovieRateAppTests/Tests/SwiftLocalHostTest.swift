//
//  SwiftLocalHostTest.swift
//  MovieRateAppTests
//
//  Created by yangjs on 2023/03/31.
//


import XCTest
import SwiftLocalhost
@testable import MovieRateApp

class SwiftLocalHostTest: XCTestCase {
    var localhostServer: LocalhostServer!
    var dataResponse1, dataResponse2, dataResponse3: Data!
    override func setUp() {
        continueAfterFailure = false
        self.localhostServer = LocalhostServer(portNumber: 1234)
        self.localhostServer.startListening()
        
        dataResponse1 = "{\"name\" : \"twok\", \"age\" : 28}".data(using: .utf8)
        
        
        self.localhostServer.route(method: .GET,
                                   path: "/3/movie/popular",
                                   responseData: dataResponse1)
        
    }
    
    override func tearDown() {
        self.localhostServer.stopListening()
    }
    
    func test_로컬서버테스트(){
        let url = URL(string: "http://127.0.0.1:1234/3/movie/popular")
        guard let url = url else { return }
        var req = URLRequest(url: url)
        req.method = .get
        URLSession.shared.dataTask(with: req) {
            resData, response, error in
            guard let resData = resData else {return}
            if let json = try? JSONSerialization.jsonObject(with: resData) as? [String : Any] {
                print(json)
            }
        }.resume()
        Thread.sleep(forTimeInterval: 1)
    }

    //    self.localhostServer.route(method: .GET,
    //                               path: "/3/movie/popular",
    //                               responseData: dataResponse2)
    //    self.localhostServer.route(method: .GET,
    //                               path: "/3/movie/popular",
    //                               responseData: dataResponse2)
    //}
}
