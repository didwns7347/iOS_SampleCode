//
//  BlogListCell.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/06.
//

import UIKit
import SnapKit
import Kingfisher

class BlogListCell : UITableViewCell{
    lazy var thumbnailImageView : UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    lazy var  titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    let dateTimeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [thumbnailImageView,nameLabel,titleLabel,dateTimeLabel].forEach {
            contentView.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(8)
            $0.trailing.lessThanOrEqualTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.trailing.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
        }
        dateTimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(thumbnailImageView)
        }
        
    }
    
    func setData(_ data: BlogListCellData){
        thumbnailImageView.kf.setImage(with: data.tumbnailURL,placeholder: UIImage(systemName: "photo"))
        nameLabel.text = data.name
        titleLabel.text = data.title
        var datetime : String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년MM월dd일"
            let contentData = data.dateTime ?? Date()
            return dateFormatter.string(from: contentData)
        }
    }
}
