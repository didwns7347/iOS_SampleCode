//
//  TodayCollectionViewCell.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/08.
//

import SnapKit
import UIKit
import Kingfisher

final class TodayCollectionViewCell: UICollectionViewCell{
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var subTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        return imageView
    }()
    

    func setUp(withData today:Today){
        setUpSubViews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        self.titleLabel.text = today.title
        self.descriptionLabel.text = today.description
        self.subTitleLabel.text = today.subTitle
        if let imageURL = URL(string: today.imageURL)
        {
            imageView.kf.setImage(with: imageURL)
        }
        
    }
    
    private func setUpSubViews(){
        self.addSubview(imageView)
        imageView.layer.cornerRadius = 12
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
     
        
        imageView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().inset(24)
        }
        
        imageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().offset(24)
        }
        
        imageView.addSubview(descriptionLabel)
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
}
