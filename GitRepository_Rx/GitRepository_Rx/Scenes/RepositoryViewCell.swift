//
//  RepositoryViewCell.swift
//  GitRepository_Rx
//
//  Created by yangjs on 2022/06/27.
//

import UIKit
import SnapKit

final class RepositoryViewCell :UITableViewCell{
    var repository : Repository? = nil
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = repository?.name
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = repository?.description
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        //label.textColor = .secondaryLabel
        return label
    }()
    
    
    private lazy var starBtn : UIButton = {
        let btn = UIButton()
        btn.tintColor = .systemPink
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        return btn
        
    }()
    
    private lazy var starCntLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .secondaryLabel
        label.text = "\(repository?.stargazersCount ?? 0)"
        
        return label
    }()
    
    
    private lazy var lagnLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .secondaryLabel
        label.text = repository?.language
        return label
    }()
    
    let leftInset :CGFloat = 12.0
    override func layoutSubviews() {
        titleLabel.text = repository?.name
        descriptionLabel.text = repository?.description
        starCntLabel.text = "\(repository?.stargazersCount)"
        lagnLabel.text = repository?.language
        [titleLabel, descriptionLabel, starBtn, starCntLabel, lagnLabel].forEach { view in
            addSubview(view)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(leftInset)
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(leftInset)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(leftInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(leftInset)
        }
        starBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(leftInset)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(leftInset/2)
        }
        starCntLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.equalTo(starBtn.snp.trailing).offset(5)
            make.bottom.equalToSuperview().inset(leftInset/2)
        }
        
        lagnLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.equalTo(starCntLabel.snp.trailing).offset(5)
            make.bottom.equalToSuperview().inset(leftInset/2)
        }
    }
 
}
