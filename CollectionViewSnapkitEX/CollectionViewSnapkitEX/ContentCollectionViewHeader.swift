//
//  ContentCollectionViewHeader.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/04/21.
//

import UIKit

class ContentCollectionViewHeader : UICollectionReusableView{
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 10, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
