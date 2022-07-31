//
//  SearchBlogNetwrok.swift
//  GitRepository_Rx
//
//  Created by yangjs on 2022/07/08.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchAPIError: Error{
    case invalidJSON
    case invalidURL
    case networkError
}


class SearchRepoNetwork{
    private let session : URLSession
    let api = SearchRepoAPI()
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func searchRepo(keyword : String) -> Single<Result<[[String:Any]],SearchAPIError>>{
        guard let url = api.searchRepo(query: keyword).url else{
            return Single.just(.failure(SearchAPIError.invalidURL))
        }
        let requset = NSMutableURLRequest(url: url)
        requset.httpMethod = "GET"
        return session.rx.data(request: requset as URLRequest)
            .map { data  in
                guard let json = try? JSONSerialization.jsonObject(with: data),
                      let result = json as? [[String:Any]]
                else{
                    return Result.failure(.invalidJSON)
                }
                return Result.success(result)
            }.asSingle()
    }
}
