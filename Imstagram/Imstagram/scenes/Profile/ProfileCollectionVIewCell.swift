//
//  ProfileCollectionVIewCell.swift
//  Imstagram
//
//  Created by yangjs on 2022/06/22.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell : UICollectionViewCell{
    private let imageView = UIImageView()
    
    func setUp(with image:UIImage){
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.backgroundColor = .tertiaryLabel
        
        
    }
}
