//
//  SearchBookViewController.swift
//  BookReviewMVP
//
//  Created by yangjs on 2023/04/27.
//

import UIKit

final class SearchBookViewController : UIViewController {
    private lazy var presenter = SearchBookViewPresenter(vc: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidload()
    }
}
extension SearchBookViewController: SearchBookProtocol {
    func  () {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        
        navigationItem.searchController = searchController
    }
}
