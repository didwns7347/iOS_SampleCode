//
//  SearchResultCollectionviewself.swift
//  SubwayInfo
//
//  Created by yangjs on 2022/06/14.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell : UICollectionViewCell{
    
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "TEST"
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "TEst"
        return label
    }()
    
    func setUpCell(){
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        backgroundColor = .systemBackground

        [mainLabel, subLabel].forEach{
            self.addSubview($0)
        }
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        subLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
