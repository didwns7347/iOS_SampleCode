//
//  TodayViewController.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/08.
//

import UIKit
import SnapKit
final class TodayViewContreoller : UIViewController{
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "today")
        collectionView.register(TodayCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCollectionViewHeader")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
extension TodayViewContreoller:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "today", for: indexPath) as? TodayCollectionViewCell
        //cell?.backgroundColor = .gray
        cell?.setUp()

       
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TodayCollectionViewHeader",
                for: indexPath
              ) as? TodayCollectionViewHeader
        else {return UICollectionReusableView()}
        header.setUpViews()
        return header
        
    }
}

extension TodayViewContreoller:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        //let height = collectionView.frame.height
        return CGSize(width:width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width-32, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value:CGFloat = 20
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewHeader", for: indexPath) as? TodayCollectionViewCell
        //else {return }
        let vc = AppDetailViewCtoneroller()
        self.present(vc, animated: true)
        
    }
}
