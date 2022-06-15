//
//  ViewController.swift
//  SubwayInfo
//
//  Created by yangjs on 2022/06/14.
//

import UIKit
import SnapKit
import Alamofire

class StationSearchViewController: UIViewController {
    private var numberOfCell: Int = 0
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
        requestStationName()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchContorller = UISearchController()
        searchContorller.searchBar.placeholder = "지하철 역을 입력해 주세요"
        //검색시 배경 화면을 어둡게 만들 것이냐?
        searchContorller.obscuresBackgroundDuringPresentation = false
        searchContorller.searchBar.delegate = self
        
        navigationItem.searchController = searchContorller
        
    }
    
    private func setTableViewLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
    }
    
    private func requestStationName(){
        let urlString = Constant.searchURL + "서울역"
        print(urlString)
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "").responseDecodable(of: StationResponseModel.self){ response in
            guard case .success(let data) = response.result
            else {
                print(response.error?.localizedDescription)
                return
                
            }
            print(data.stations)
        }.resume()
    }

}
extension StationSearchViewController : UISearchBarDelegate{ 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberOfCell = 10
        self.tableView.isHidden = false
        tableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)  {
        numberOfCell = 0
        self.tableView.isHidden = true
    }
    
}

extension StationSearchViewController: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
extension StationSearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SearchResultViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
