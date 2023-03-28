//
//  ViewContr/Users/yangjs/Documents/강의 실습/MovieRateApp/MovieRateApp/MovieListPresenter.swiftoller.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/27.
//
import SnapKit
import UIKit

final  class MovieListViewController: UIViewController {
    private lazy var presenter = MovieListPresenter(viewcontroller: self)
    private let searchController = UISearchController()
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter

        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    private lazy var searchResultTableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = presenter
        tv.delegate = presenter
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
}
extension MovieListViewController: MovieListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }

    func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(searchResultTableView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.isHidden = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        searchResultTableView.isHidden = isHidden
        searchResultTableView.reloadData()
    }
}
