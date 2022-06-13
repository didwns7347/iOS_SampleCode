//
//  TodayCollectionViewHeader.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/09.
//

import UIKit
import SnapKit

final class TodayCollectionViewHeader :UICollectionReusableView{
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "6월 9일 목요일"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36.0, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    func setUpViews(){
        [dateLabel, titleLabel].forEach{
            addSubview($0)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
    }
}
