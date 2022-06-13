//
//  FeatureSectionCell.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/10.
//

import UIKit
import SnapKit

class FeatureSectionCell :UICollectionViewCell{
    private lazy var subTitle:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemBlue
        label.text = "test"
        return label
    }()
    
    private lazy var title:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = "test"
        return label
    }()
    
    private lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        label.text = "test"
        return label
    }()
    
    private lazy var iamge:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 7
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        return imageView
    }()
    
    func setUP(){
        setUpSubViews()
    }
    
    func setUpSubViews(){
        self.addSubview(subTitle)
        subTitle.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
        }
        
        self.addSubview(title)
        title.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(subTitle.snp.bottom)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(title.snp.bottom).offset(4)
        }
        
        self.addSubview(iamge)
        iamge.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview().inset(8.0)
    
        }
    }
}
