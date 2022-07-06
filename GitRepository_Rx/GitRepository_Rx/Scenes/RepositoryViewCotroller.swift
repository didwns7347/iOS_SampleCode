//
//  ViewController.swift
//  GitRepository_Rx
//
//  Created by yangjs on 2022/06/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa



class RepositoryViewCotroller: UIViewController {
    private let repositores = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    private let organization = "didwns7347"
    //private let refreshControl = UIRefreshControl()
    private lazy var tableview : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        
        tableView.register(RepositoryViewCell.self, forCellReuseIdentifier:"cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        self.tableview.refreshControl = UIRefreshControl()
        let refreshControl = self.tableview.refreshControl
        
        refreshControl?.backgroundColor = .white
        refreshControl?.tintColor = .darkGray
        refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refresh()
        
    }
    
    @objc func refresh(){
        DispatchQueue.global(qos: .background).async{ [weak self] in
            guard let self = self else {return}
            self.fetchRepository(of: self.organization)
            
        }
    }
    
    func fetchRepository(of organization: String){
        Observable<String>.from([organization])
            .map{ organization -> URL in
                return URL(string: "https://api.github.com/users/\(organization)/repos")!
            }
            .map { url -> URLRequest in
                var requset = URLRequest(url: url)
                requset.httpMethod = "GET"
                return requset
            }.flatMap { requset -> Observable<(response: HTTPURLResponse, data:Data)> in
                return URLSession.shared.rx.response(request: requset)
            }.filter { response , _ in
                return 200 <= response.statusCode && response.statusCode<300
            }.map{ _ , data -> [[String:Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data),
                      let result = json as? [[String:Any]]
                else{
                    return []
                }
                return result
            }.filter{
                $0.count > 0
            }.map { json in
                return json.compactMap
                { dict -> Repository? in
                    guard let id = dict["id"] as? Int,
                          let name = dict["name"] as? String,
                          let fullName = dict["full_name"] as? String,
                          let stargazersCount = dict["stargazers_count"] as? Int,
                          let language = dict["language"] as? String
                    else{
                        return nil
                    }
                    return Repository(id: id, name:name, description:fullName, stargazersCount: stargazersCount, language: language)
                          
                }
            }.subscribe(
                onNext:{[weak self] newRepositories in
                    guard let self = self else {return }
                    self.repositores.onNext(newRepositories)
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                        self.tableview.refreshControl?.endRefreshing()
                    }
                }
            ).disposed(by: disposeBag)
        
        /*
        Observable.from([organization])
            .map{ organization -> URL in
                return URL(string:"https://api.github.com/orgs/\(organization)/repos")!
            }
            .map{ url->URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap{request -> Observable<(response: HTTPURLResponse, data : Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter{ response, _ in
                return 200..<300 ~= response.statusCode
                
            }
            .map{ _, data -> [[String:Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data),
                        let result = json as? [[String:Any]] else{
                    return []
                }
                return result
            }
            .filter { result in
                result.count>0
            }
            .map{ objects in
                return objects.compactMap{ dic -> Repository? in
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let description = dic["description"] as? String,
                          let stargazersCount = dic["stargazers_count"] as? Int,
                          let language = dic["language"] as? String
                    else{
                        return nil
                    }
                    return Repository(id: id, name: name, description: description, stargazersCount: stargazersCount, language: language)
                }
            }
            .subscribe(onNext: { [weak self] newRepositories in
                self?.repositores.onNext(newRepositories)
                DispatchQueue.main.sync {
                    self?.tableview.reloadData()
                    self?.tableview.refreshControl?.endRefreshing()
                }
              
            })
            .disposed(by: disposeBag)*/
    }


}
extension RepositoryViewCotroller : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do{
            return try repositores.value().count
        }catch{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoryViewCell

        var currentRepo : Repository? {
            do{
                return try repositores.value()[indexPath.row]
            }catch{
                return nil
            }
        }
        cell?.repository = currentRepo
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

private extension RepositoryViewCotroller{
    func setupNavigation(){
        navigationItem.title = "Apple Repository"
    }
    func setupTableView(){
        view.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

