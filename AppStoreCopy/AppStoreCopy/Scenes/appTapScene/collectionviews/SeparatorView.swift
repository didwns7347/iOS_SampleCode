//
//  SeparatorView.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/10.
//

import UIKit
import SnapKit

final class SeparatorView:UIView{
    private lazy var separator:UIView = {
        let seporator = UIView()
        seporator.backgroundColor = .separator
        return seporator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemetated")
    }
}
