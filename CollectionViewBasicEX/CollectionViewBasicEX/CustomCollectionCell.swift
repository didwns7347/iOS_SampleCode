//
//  CustomCollectionCell.swift
//  CollectionViewBasicEX
//
//  Created by yangjs on 2022/04/26.
//

import UIKit
import SnapKit

class CustomCollectionCell: UICollectionViewCell{
    static let identifier = "CustomCollectionCell"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setImageView()
    }
    
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    required init?(coder aDecorder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setImageView(){
            backgroundColor = .systemGroupedBackground
            
            addSubview(imageView)
            
            imageView.snp.makeConstraints {
                $0.top.bottom.left.right.equalToSuperview()
            }
        }

}
