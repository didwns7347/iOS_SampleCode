//
//  SearchBlogNetwork.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa
enum SearchNetworkError:Error{
    case invalidJSON
    case networkError
    case invalidURL
}


class SearchBlogNetwork{

    
    private let session : URLSession
    let api = SearchBlogAPI()
    
    init(session : URLSession = .shared){
        self.session = session
    }
    
    func searchBlog(query:String) -> Single<Result<DKBlog,SearchNetworkError>>{
        guard let url = api.searchBlog(query: query).url else{
            return .just(.failure(SearchNetworkError.invalidURL))
        }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("???????", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return session.rx.data(request: request as URLRequest)
            .map{ data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                }catch{
                    return .failure(.invalidJSON)
                }
                
            }.catch { _ in
                    .just(.failure(.networkError))
            }.asSingle()
    }
}
