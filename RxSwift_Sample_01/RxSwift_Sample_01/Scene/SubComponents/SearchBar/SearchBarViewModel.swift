//
//  SearchViewModel.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/14.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let searchButtonTapped = PublishRelay<Void>()
    let shouldLoadResult :Observable<String>
    
    init(){
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText){ $1 ?? ""}
            .filter{ !$0.isEmpty }
            .distinctUntilChanged()
    }
}
