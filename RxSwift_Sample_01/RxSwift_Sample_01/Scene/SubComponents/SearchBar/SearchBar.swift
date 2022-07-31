//
//  SearchBar.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/01.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

class SearchBar : UISearchBar{
    let disposeBag = DisposeBag()
    let searchBtn = UIButton()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(_ viewModel : SearchBarViewModel){
        
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag )
        //서치 바의 버튼이 탭 된경우( 키보드 앤터)
        //서치바 옆에 검색 버튼이 눌린경우
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchBtn.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped )
            .disposed(by: disposeBag)
        //UI관련이라 ASSignal로가는듯
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)//연결
            .disposed(by: disposeBag)
        
       
    }
    
    private func attribute(){
        searchBtn.setTitle("검색", for: .normal)
        searchBtn.setTitleColor(.systemBlue, for: .normal)
        
    }
    
    private func layout(){
        addSubview(searchBtn)
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(searchBtn.snp.leading).offset(12)
            make.centerY.equalToSuperview()
        }
        
        searchBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
        
    }
}
extension Reactive where Base : SearchBar{
    var endEditing: Binder<Void>{
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    } }
 
 
