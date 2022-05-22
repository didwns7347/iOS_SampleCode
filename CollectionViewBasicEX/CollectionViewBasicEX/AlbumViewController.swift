//
//  AlbumViewController.swift
//  CollectionViewBasicEX
//
//  Created by yangjs on 2022/04/26.
//

import UIKit

class AlbumViewController: UICollectionViewController {
    var image = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Linked")
        // Do any additional setup after loading the view.
        
        collectionView.backgroundColor = .white
        
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.identifier)
        
        for i in 0...20{
            image.append("poster\(i)")
        }
        collectionView.collectionViewLayout = layout()
        
    }
    private func layout()->UICollectionViewLayout{
        return UICollectionViewCompositionalLayout{[weak self] sectionNum,env -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            return self.createBasicTypeSection()
        }
    }
    
    private func createBasicTypeSection()->NSCollectionLayoutSection{
        //item
        let itemSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let gsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: gsize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    //셀 의수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
        cell.imageView.image = UIImage(named: image[indexPath.row])
        return cell
    }


}


