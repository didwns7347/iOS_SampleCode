//
//  RepositoryViewModel.swift
//  GitRepository_Rx
//
//  Created by yangjs on 2022/08/18.
//

import Foundation
import RxSwift
import RxCocoa

struct RepositoryViewModel {
    private let organization = "didwns7347"
    let repositoryies = BehaviorSubject<[Repository]>(value: [])
    let fetchRepostiroy = PublishRelay<Void>()
    let bag = DisposeBag()
    
    init(id:String){
        let fetchData =  fetchRepostiroy
            .map { _ in
                URL(string: "https://api.github.com/users/\(id)/repos")!
            }
            .map{
                URLRequest(url: $0)
            }
            .flatMap{
                URLSession.shared.rx.data(request: $0)
            }.map{ data in
                return RepositoryList.parse(data: data)
            }
        
        fetchData.bind(to: repositoryies)
            .disposed(by: bag)
    
    }
}
