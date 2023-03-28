//
//  MovieListPresenter.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/28.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateSearchTableView(isHidden: Bool)
    func pushToMovieViewController(with movie: Movie)
    func updateCollectionView()
}

final class MovieListPresenter: NSObject {
    private weak var viewcontroller: MovieListProtocol?
    private let userDefaultManager: UserDefaultManegerProtocol
    private let movieSearchManager: MoviewSearchManageable
    private var likedMovie: [Movie] = []
    
    private var currentMovieSearchResult: [Movie] = []

    init(
        viewcontroller: MovieListProtocol,
        movieSearchManager: MoviewSearchManageable = MovieSearchManager(),
        userDefaultManager: UserDefaultManegerProtocol = UserdefaultManager()
    ) {
        self.viewcontroller = viewcontroller
        self.movieSearchManager = movieSearchManager
        self.userDefaultManager = userDefaultManager
    }
    func viewDidLoad() {
        viewcontroller?.setupNavigationBar()
        viewcontroller?.setupSearchBar()
        viewcontroller?.setupViews()
    }
    
    func viewWillAppear() {
        likedMovie = userDefaultManager.getMovies()
        viewcontroller?.updateCollectionView()
        
    }
}

extension MovieListPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewcontroller?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult = []
        viewcontroller?.updateSearchTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(form: searchText) { [weak self] movies in
            self?.currentMovieSearchResult = movies
            self?.viewcontroller?.updateSearchTableView(isHidden: false)
        }
    }
}
extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing*3)/2
        return CGSize(width: width, height: 210.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(
            top: inset,
            left: inset,
            bottom: inset,
            right: inset
        )
    }

}
extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        likedMovie.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell

        let movie = likedMovie[indexPath.row]
        cell?.update(movie)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = likedMovie[indexPath.row]
        viewcontroller?.pushToMovieViewController(with: movie)
    }
}

extension MovieListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = currentMovieSearchResult[indexPath.row]
        viewcontroller?.pushToMovieViewController(with: movie)
    }
}
extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentMovieSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title
        return cell
    }
    
    
}
