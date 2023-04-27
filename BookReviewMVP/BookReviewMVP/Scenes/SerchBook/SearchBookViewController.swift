//
//  SearchBookViewController.swift
//  BookReviewMVP
//
//  Created by yangjs on 2023/04/27.
//

import UIKit
import SnapKit
final class SearchBookViewController : UIViewController {
    lazy var presenter = SearchBookViewPresenter(vc: self)
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidload()
    }
}
extension SearchBookViewController: SearchBookProtocol {
    func setUpViews() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        
        navigationItem.searchController = searchController
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func dismiss() {
        navigationItem.searchController?.dismiss(animated: true)
        self.dismiss(animated: true)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
