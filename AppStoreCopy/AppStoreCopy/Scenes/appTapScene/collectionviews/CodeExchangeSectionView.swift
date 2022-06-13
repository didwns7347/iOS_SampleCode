//
//  CodeExchangeSectionView.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/13.
//

import UIKit
import SnapKit

final class CodeExchangeView : UIView{
    private lazy var codeExchangeBtn :UIButton = {
        let btn = UIButton()
        btn.setTitle("코드 교환", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        btn.layer.cornerRadius = 7
        btn.backgroundColor = .tertiarySystemGroupedBackground
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        addSubview(codeExchangeBtn)
        codeExchangeBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(32)
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
}
