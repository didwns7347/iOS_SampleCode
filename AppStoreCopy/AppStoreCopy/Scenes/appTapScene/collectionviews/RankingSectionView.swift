//
//  RankingSectionView.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/10.
//

import UIKit
import SnapKit

final class RankingViewSection: UIView{
    //private let cellHegiht:CGFloat = 30.0
    var ranking:[RankingFeature] = []
    
    private lazy var rankingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
 
        //collection.backgroundColor = .gray
        collectionView.register(RankingViewCell.self, forCellWithReuseIdentifier: "RankingViewCell")
        
        return collectionView
    }()
    
    private lazy var firstLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.text = "iPhone이 처음이라면"
        return label
    }()
    
    private lazy var button :UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return button
    }()
    
    private let separator = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [rankingCollection,firstLabel,button,separator].forEach { view in
            addSubview(view)
        }
        self.fetchData()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        firstLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        button.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
        rankingCollection.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(16)
            make.height.equalTo(RankingViewCell.cellHeight * 3)
            make.leading.trailing.equalToSuperview()
        }
        separator.snp.makeConstraints { make in
            make.top.equalTo(rankingCollection.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
}
extension RankingViewSection:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ranking.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingViewCell", for: indexPath) as? RankingViewCell
        cell?.setUpCell(with: ranking[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    
}
extension RankingViewSection:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.width-32, height: RankingViewCell.cellHeight
        )
    }
}
private extension RankingViewSection{
    func fetchData(){
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else{return}
        do{
            let data = try Data(contentsOf: url)
            let res = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            ranking = res
        }catch{}
    }
}
