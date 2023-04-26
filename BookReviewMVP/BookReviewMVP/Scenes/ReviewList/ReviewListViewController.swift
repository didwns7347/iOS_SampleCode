//
//  ViewController.swift
//  BookReviewMVP
//
//  Created by 양준수 on 2023/04/12.
//

import UIKit
import SnapKit
class ReviewListViewController: UIViewController {
 
    private lazy var presenter = ReviewListPresenter(vc: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    


}

extension ReviewListViewController: ReviewListProtocol {
    func setUpNavigationBar(){
        navigationItem.title = "도서리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didRightBarButtonItemTapped)
        )
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setUpViews(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func presentReviewWriteVC() {
        let vc = UINavigationController(rootViewController: ReviewWriteViewController())
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
extension ReviewListViewController {
    @objc func didRightBarButtonItemTapped(){
        presenter.didRightBarButtonTapped()
    }
}
