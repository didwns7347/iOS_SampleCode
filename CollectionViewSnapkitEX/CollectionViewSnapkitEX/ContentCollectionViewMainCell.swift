//
//  ContentCollectionViewMainCell.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/04/25.
//

import UIKit

class ContentCollectionViewMainCell : UICollectionViewCell{
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    let tvBtn = UIButton()
    let movieBtn = UIButton()
    let categoryBtn = UIButton()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusBtn = UIButton()
    let playBtn = UIButton()
    let infoBtn = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [baseStackView,menuStackView].forEach{
            contentView.addSubview($0)
        }
        
        //baseSV Layout
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        [imageView,descriptionLabel,contentStackView].forEach{
            baseStackView.addArrangedSubview($0)
        }
        
        //imageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        //descriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        //contentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalSpacing
        contentStackView.spacing = 20
        
        [plusBtn,infoBtn].forEach{
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusBtn.setTitle("내가 찜한 컨텐츠", for: .normal)
        plusBtn.setImage(UIImage(systemName: "plus"), for:.normal)
        plusBtn.addTarget(self, action:#selector(plusBtnTapped), for: .touchUpInside)
        
        infoBtn.setTitle("정보", for: .normal)
        infoBtn.setImage(UIImage(systemName: "info.circle"), for:.normal)
        infoBtn.addTarget(self, action:#selector(infoBtnTapped), for: .touchUpInside)
        
        playBtn.setTitle("► 재생", for: .normal)
        playBtn.setTitleColor(.black, for: .normal)
        playBtn.backgroundColor = .white
        playBtn.layer.cornerRadius = 3
        playBtn.snp.makeConstraints{
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playBtn.addTarget(self, action: #selector(playBtnTapped), for: .touchUpInside)
        
        [plusBtn,playBtn,infoBtn].forEach{
            contentStackView.addArrangedSubview($0)
        }
        
        contentStackView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        baseStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        //menuSV Layout
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        self.menuStackView.distribution = .equalSpacing
        self.menuStackView.spacing = 20
        
        [tvBtn,movieBtn,categoryBtn].forEach{
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        tvBtn.setTitle("TV 프로그램", for: .normal)
        movieBtn.setTitle("영화", for: .normal)
        categoryBtn.setTitle("카테고리 ▼", for: .normal)
        
        tvBtn.addTarget(self, action: #selector(tvBtnTapped), for: .touchUpInside)
        movieBtn.addTarget(self, action: #selector(movieBtnTapped), for: .touchUpInside)
        categoryBtn.addTarget(self, action: #selector(categoryBtnTapped), for: .touchUpInside)
        
        self.menuStackView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func tvBtnTapped(sender: UIButton){
        print("TEST:TV BUTTON TAPPED")
    }
    @objc func movieBtnTapped(sender: UIButton){
        print("TEST:Movie BUTTON TAPPED")
    }
    @objc func categoryBtnTapped(sender: UIButton){
        print("TEST:Category BUTTON TAPPED")
    }
    @objc func plusBtnTapped(sender: UIButton){
        print("TEST:Plus BUTTON TAPPED")
    }
    @objc func infoBtnTapped(sender: UIButton){
        print("TEST:Info BUTTON TAPPED")
    }
    
    @objc func playBtnTapped(sender: UIButton){
        print("TEST:Info BUTTON TAPPED")
    }
}

