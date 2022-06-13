//
//  FeatureSectionView.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/09.
//

import UIKit
import SnapKit

final class FeatureSectionView :UIView{
    private lazy var featureCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(FeatureSectionCell.self, forCellWithReuseIdentifier: "FeatureSectionCell")
        
        
        return collectionView
    }()
    private lazy var separator:SeparatorView = {
        let view = SeparatorView(frame: .zero)
        return view
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView(){
        self.addSubview(featureCollection)
        featureCollection.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(snp.width)
            make.top.equalToSuperview().inset(16)
        }
        self.addSubview(separator)
        separator.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(featureCollection.snp.bottom).offset(16)
        }
    }
}
extension FeatureSectionView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: frame.width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
}
extension FeatureSectionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCell", for: indexPath) as? FeatureSectionCell
        cell?.setUP()
        return cell ?? UICollectionViewCell()
    }
    
    
}
