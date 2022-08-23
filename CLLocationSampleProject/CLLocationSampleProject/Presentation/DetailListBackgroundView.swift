//
//  DetailListBackgroundView.swift
//  CLLocationSampleProject
//
//  Created by yangjs on 2022/08/19.
//

import Foundation
import RxCocoa
import RxSwift

class DetailListBackgroundView: UIView{
    let bag = DisposeBag()
    let statusLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(vm: DetailListBackgroundViewModel){
        vm.isStatusHidden
            .emit(to: statusLabel.rx.isHidden)
            .disposed(by: bag)
    }
    
    private func attribute(){
        backgroundColor = .white
        statusLabel.text = "텅"
        statusLabel.textAlignment = .center
    }
    
    private func layout(){
        addSubview(statusLabel)
        statusLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
