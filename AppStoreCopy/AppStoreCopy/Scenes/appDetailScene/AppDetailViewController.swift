//
//  AppDetailViewController.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/13.
//

import UIKit
import SnapKit

final class AppDetailViewCtoneroller : UIViewController{
    private lazy var appImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        return img
    }()
    
    private lazy var appName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var downloadBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("받기", for:.normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private lazy var shareBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.tintColor = .systemBlue
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpView()
        appImg.backgroundColor = .lightGray
        
    }
    
    private func setUpView(){
        [appImg,appName,downloadBtn,shareBtn,descLabel].forEach{
            view.addSubview($0)
        }
        
        appImg.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(100.0)
            make.width.equalTo(appImg.snp.height)
        }
        
        appName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(appImg.snp.trailing).offset(16)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(appName.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(appImg.snp.trailing).offset(16)
        }
        
        downloadBtn.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(32)
            make.leading.equalTo(appImg.snp.trailing).offset(32)
            make.bottom.equalTo(appImg.snp.bottom)
        }
        
        shareBtn.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(appImg.snp.bottom)
        }
        
    }
}
