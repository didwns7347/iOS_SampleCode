//
//  SearchResultVC.swift
//  SubwayInfo
//
//  Created by yangjs on 2022/06/14.
//

import UIKit
import SnapKit
import Alamofire

class SearchResultViewController : UIViewController{
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: "SearchResult")
        collectionView.dataSource = self
        collectionView.refreshControl = self.refreshControl
        return collectionView
    }()
    
    private lazy var refreshControl : UIRefreshControl = {
        let rfc = UIRefreshControl()
        rfc.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return rfc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "왕십리"
        setupCollectionView()
        fetchData()
    }
    
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
                //make.top.equalTo(navigationController?.navigationBar.snp.bottom).offset(30)
        }
    }
    
    @objc func fetchData(){
        print("REFRESH")
        //refreshControl.endRefreshing()
        
        var stationName = "서울역"
        stationName = stationName.replacingOccurrences(of: "역", with: "")
        let urlString = Constant.arrivalURL + "서울"
        
        print(urlString)
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDataResponseModel.self){ [weak self] response in
                self?.refreshControl.endRefreshing()
                guard case .success(let data) = response.result
                else {
                    print(response.error?.localizedDescription)
                    return
                    
                }
                
                print(data.realtimeArrivalList)
                
                
            }.resume()
    }

}
extension SearchResultViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResult", for: indexPath)
        as? SearchResultCollectionViewCell else {return UICollectionViewCell()}
                                                          
        cell.setUpCell()
       
        //cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    
}
