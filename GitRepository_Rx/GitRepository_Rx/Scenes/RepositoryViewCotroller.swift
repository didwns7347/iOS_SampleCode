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
    private let refreshControl = UIRefreshControl()
    private lazy var tableview : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        
        tableView.register(RepositoryViewCell.self, forCellReuseIdentifier:"cell")
        return tableView
    }()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(vm:RepositoryViewModel){
        vm.repositoryies
            .bind(to: self.tableview.rx.items(cellIdentifier: "cell", cellType: RepositoryViewCell.self)) { row, repository, cell in
                cell.repository = repository
                cell.layoutSubviews()
            }.disposed(by: disposeBag)
        
        self.refreshControl.rx.controlEvent(.valueChanged)
            .do(onNext:{ [weak self] in
                guard let self = self else{
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+3){
                    self.refreshControl.endRefreshing()
                }
            })
            .bind(to: vm.fetchRepostiroy)
                .disposed(by: disposeBag)
        
            
    }
    
    
//    @objc func refresh(){
//        DispatchQueue.global(qos: .background).async{ [weak self] in
//            guard let self = self else {return}
//            self.fetchRepository(of: self.organization)
//
//        }
//    }
//
//    func fetchRepository(of organization: String){
//        Observable<String>.from([organization])
//            .map{ organization -> URL in
//                return URL(string: "https://api.github.com/users/\(organization)/repos")!
//            }
//            .map { url -> URLRequest in
//                var requset = URLRequest(url: url)
//                requset.httpMethod = "GET"
//                return requset
//            }.flatMap { requset -> Observable<(response: HTTPURLResponse, data:Data)> in
//                return URLSession.shared.rx.response(request: requset)
//            }.filter { response , _ in
//                return 200 <= response.statusCode && response.statusCode<300
//            }.map{ _ , data -> [[String:Any]] in
//                guard let json = try? JSONSerialization.jsonObject(with: data),
//                      let result = json as? [[String:Any]]
//                else{
//                    return []
//                }
//                return result
//            }.filter{
//                $0.count > 0
//            }.map { json in
//                return json.compactMap
//                { dict -> Repository? in
//                    guard let id = dict["id"] as? Int,
//                          let name = dict["name"] as? String,
//                          let fullName = dict["full_name"] as? String,
//                          let stargazersCount = dict["stargazers_count"] as? Int,
//                          let language = dict["language"] as? String
//                    else{
//                        return nil
//                    }
//                    return Repository(id: id, name:name, description:fullName, stargazersCount: stargazersCount, language: language)
//
//                }
//            }.subscribe(
//                onNext:{[weak self] newRepositories in
//                    guard let self = self else {return }
//                    self.repositores.onNext(newRepositories)
//                    DispatchQueue.main.async {
//                        self.tableview.reloadData()
//                        self.tableview.refreshControl?.endRefreshing()
//                    }
//                }
//            ).disposed(by: disposeBag)
//    }
}


private extension RepositoryViewCotroller{
    func setupNavigation(){
        navigationItem.title = "Apple Repository"
    }
    func setupTableView(){
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func attribute(){
        refreshControl.endRefreshing()
        self.tableview.refreshControl = refreshControl
        
        setupNavigation()
    }
    
    func layout(){
        setupNavigation()
        setupTableView()
    }
}

