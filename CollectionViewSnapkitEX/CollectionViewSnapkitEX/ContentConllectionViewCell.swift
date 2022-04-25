//
//  ContentConllectionViewCell.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/04/21.
//

import UIKit

import SnapKit

class ContentCollectionViewCell : UICollectionViewCell{
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        imageView.snp_makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
