//
//  BlogListViewModel.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/14.
//

import RxCocoa
import RxSwift
import Darwin

struct BlogListViewModel{
    let filterVM = FilterViewModel()
    let blogCellData = PublishSubject<[BlogListCellData]>()
    
    let cellData : Driver<[BlogListCell]>
    
    init(){
        self.cellData = blogCellData.asDriver(onErrorJustReturn: [])
    }
}
