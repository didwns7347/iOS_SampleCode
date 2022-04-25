//
//  HomeViewController.swift
//  CollectionViewSnapkitEX
//
//  Created by yangjs on 2022/04/18.
//

import UIKit
import SwiftUI

class HomeViewController : UICollectionViewController{
    var contents: [Content] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //네이비게이션 설정
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "netflix_icon.png")
                                                           , style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        //DAta 설정
        contents = getContent()
        
        //CollectionView Item(Cell)설정
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader")
    }
    
    func getContent()-> [Content]{
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return []}
        return list
    }
    
}

//UICollectionView Datasource , Delegate
extension HomeViewController{
    //섹션당 보여줄 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    //콜렌션부 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {return UICollectionViewCell()}
            cell.imageView.image =  contents[indexPath.section].contentItem[indexPath.row].image
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //헤더 뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath)
            as? ContentCollectionViewHeader else {fatalError("Could not deque Header")}
            
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        }else{
            return UICollectionReusableView()
        }
    }
    
    //section how many
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("TEST : \(sectionName)섹션의 \(indexPath.row+1)번째 콘텐츠")
    }
}


//SwiftUI를 활용한 미리보기
struct HomeViewController_Preview: PreviewProvider{
    static var previews: some View{
        Container().edgesIgnoringSafeArea(.all)
        
    }
    
    struct Container : UIViewControllerRepresentable{
     
     
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
            
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
          typealias UIViewControllerType = UIViewController
    }
}
