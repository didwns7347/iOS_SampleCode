//
//  BearListViewController.swift
//  HttpBeerPractice
//
//  Created by yangjs on 2022/05/03.
//

import UIKit

class BeerListViewController:UITableViewController {
    var beerList = [Beer]()
    var currentPage = 1
    var dataTasks = [URLSessionTask]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar Custom
        let title = "맥주 지리게"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //uitalbe view 설정
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
        fetchBeer(of: self.currentPage)
        
    }
    
}


//UITableView DataSouce, Delegate
extension BeerListViewController: UITableViewDataSourcePrefetching{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Rows:\(indexPath.row)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else {return UITableViewCell()}
        
        let beer = beerList[indexPath.row]
        cell.getConfigure(with: beer)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailVC = BeerDetailViewController()
        detailVC.beer = selectedBeer
        self.show(detailVC,sender: nil)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else{ return }
        
        indexPaths.forEach{
            if (($0.row + 1 )/25 + 1) == currentPage{
                self.fetchBeer(of: currentPage)
            }
        }
        
        
    }
    
    
}


//DataFecting
private extension BeerListViewController{
    func fetchBeer(of page:Int){
        guard let url =  URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
        dataTasks.firstIndex(where: { task in
            task.originalRequest?.url == url
        })==nil
        else {return}
        var requet = URLRequest(url: url)
        requet.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: requet) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else{
                print("ERROR: URLSession ERROR : \(error?.localizedDescription)")
                return
            }
            switch response.statusCode{
            case (200...299):
                self.beerList += beers
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499):
                print("""
                        ERROR : Client Error\(response.statusCode)
                        Response : \(response)
                        """)
            case (500...599):
                print("""
                        ERROR : Server Error\(response.statusCode)
                        Response : \(response)
                        """)
            default:
                print("""
                        ERROR : \(response.statusCode)
                        Response : \(response)
                        """)
                
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
        
    }
}
