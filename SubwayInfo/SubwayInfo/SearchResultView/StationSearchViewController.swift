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
    private var stationList :StationResponseModel? = nil
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        //tableView.register(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "Cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
        //requestStationName(stationName: "서울역")
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
    
    private func requestStationName(stationName: String){
        let urlString = Constant.searchURL + stationName
        print(urlString)
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "").responseDecodable(of: StationResponseModel.self){ [weak self] response in
            guard case .success(let data) = response.result
            else {
                print(response.error?.localizedDescription)
                return
                
            }
            print(data.stations)
            self?.stationList = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
          
            
        }.resume()
    }

}
extension StationSearchViewController : UISearchBarDelegate{ 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberOfCell = self.stationList?.stations.count ?? 0
        self.tableView.isHidden = false
        tableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)  {
        numberOfCell = 0
        self.tableView.isHidden = true
        self.stationList = nil
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(stationName: searchText)
        
    }
}

extension StationSearchViewController: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationList?.stations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        guard let station = self.stationList?.stations[indexPath.row] else{
            return cell
        }
        cell.textLabel?.text = "\(station.stationName)"
        cell.detailTextLabel?.text = "\(station.lineNumber)"
        //cell.detailTextLabel?.text = station.lineNumber
        return cell
    }
}
extension StationSearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SearchResultViewController()
        vc.stationName = self.stationList?.stations[indexPath.row].stationName
        navigationController?.pushViewController(vc, animated: true)
    }
}
