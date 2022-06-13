//
//  RankingViewCell.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/10.
//

import UIKit
import SnapKit
final class RankingViewCell : UICollectionViewCell{
    static let cellHeight:CGFloat = 70.0
    private lazy var imageView:UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 7
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        return imageView
    }()
    
    private lazy var appName:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "TEST"
        return label
    }()
    private lazy var descLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor  = .secondaryLabel
        label.text = "TEST"
        return label
    }()
    
    private lazy var downloadBtn :UIButton = {
        let btn = UIButton()
        btn.setTitle("받기", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .secondarySystemBackground
        return btn
    }()
    
    private lazy var inAppPayment :UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.text = "앱 내 구입"
        label.textColor = .secondaryLabel
        return label
    }()
    
    func setUpCell(){
        setUpsubViews()
    }
    
    private func setUpsubViews(){
        [imageView,appName,descLabel,downloadBtn,inAppPayment].forEach{
            addSubview($0)

        }
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(imageView.snp.height)
        }
        
        
        
      
        downloadBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
        }
        
        inAppPayment.snp.makeConstraints { make in
            make.centerX.equalTo(downloadBtn.snp.centerX)
            make.top.equalTo(downloadBtn.snp.bottom).offset(4)
        }
        appName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalTo(downloadBtn.snp.leading)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(appName.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        
    }
}
