//
//  FilterView.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/06.
//

import RxSwift
import RxCocoa
import UIKit

class FilterView :UITableViewHeaderFooterView{
    let disposeBag = DisposeBag()
    
    let sortButton = UIButton()
    let bottomBorder = UIView()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

private extension FilterView{
    func bind(_ viewModel:FilterViewModel){
        sortButton.rx.tap
            .bind(to: viewModel.sortButtonTapped)
            .disposed(by: disposeBag)
        
    }
    
    func attribute(){
        sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        bottomBorder.backgroundColor = .lightGray
    }
    
    func layout(){
        [sortButton,bottomBorder].forEach{
            addSubview($0)
            
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
            make.width.height.equalTo(20)
        }
        
        bottomBorder.snp.makeConstraints{
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
