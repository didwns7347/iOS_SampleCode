//
//  SearchBar.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/01.
//

import RxSwift
import RxCocoa
import UIKit

class SearchBar : UISearchBar{
    let disposeBag = DisposeBag()
    let searchBtn = UIButton()
    
    
    //searchBar 버튼 탭 이벤트
    let searchBarButtonTapped = PublishRelay<Void>()
    
    //searchBar 외부로 내보넬 이벤트
    let shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        //서치 바의 버튼이 탭 된경우( 키보드 앤터)
        //서치바 옆에 검색 버튼이 눌린경우
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchBtn.rx.tap.asObservable()
            )
            .bind(to: searchBarButtonTapped)
            .disposed(by: disposeBag)
        searchBarButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
       
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        
    }
}
extension Reactive where Base : SearchBar{
    var endEditing: Binder<Void>{
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    } }
 
