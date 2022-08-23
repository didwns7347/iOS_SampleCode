//
//  DetailListBacgroundViewModel.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/19.
//

import RxCocoa
import RxSwift

struct DetailListBackgroundViewModel{
    let isStatusHidden : Signal<Bool>
    let sholdHideStatusLabel = PublishSubject<Bool>()
    
    init(){
        isStatusHidden = sholdHideStatusLabel.asSignal(onErrorJustReturn: true)
    }
}
