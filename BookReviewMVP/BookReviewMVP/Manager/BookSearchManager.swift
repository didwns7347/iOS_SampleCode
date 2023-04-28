//
//  BookSearchManager.swift
//  BookReviewMVP
//
//  Created by yangjs on 2023/04/27.
//
import Alamofire
import Foundation
protocol BookSearchManagerProtocol {
    func request(from keyword:String , completionHandler:@escaping(([Book]) -> Void) )
}

struct BookSearchManager :BookSearchManagerProtocol{
    
    //ID JV9iODq3L_I73ufESxUq
    //secret zD8huRCDka
    func request(from keyword: String, completionHandler: @escaping(([Book]) -> Void)) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else {
            return
        }
        
        let parameters = BookSearchRequestModel(query: keyword)
        
        let header : HTTPHeaders = [
            "X-Naver-Client-Id" : "JV9iODq3L_I73ufESxUq",
            "X-Naver-Client-Secret" : "zD8huRCDka"
        ]
        
        AF.request(url, method: .get, parameters: parameters ,headers: header)
            .responseDecodable(of:BookSearchResponseModel.self) { response in
                switch response.result{
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
        
    }
}
