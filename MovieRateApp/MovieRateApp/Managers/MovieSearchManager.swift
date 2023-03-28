//
//  MovieSearchManager.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/27.
//

import Foundation
import Alamofire
protocol MoviewSearchManageable {
    func request(form keyword: String, completionHandler: @escaping ((_ movies: [Movie]) -> Void) )
}

struct MovieSearchManager: MoviewSearchManageable {
    func request(form keyword: String, completionHandler: @escaping ((_ movies: [Movie]) -> Void) ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json")
        else {return}
        let parameters = MovieSearchRequestModel(query: keyword)
        // X-Naver-Client-Id:jU4yrdFZYfUnQ6yMtiHX  X-Naver-Client-Secret:  wmQrIFSIcr
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "jU4yrdFZYfUnQ6yMtiHX",
            "X-Naver-Client-Secret": "wmQrIFSIcr"
        ]
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: MovieSearchResponseModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.items)
            case .failure(let error):
                print(error)
            }
        }
        .resume()
    }
}
