//
//  MovieDetailPresenter.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/28.
//

import Foundation
protocol MovieDetailProtocol: AnyObject {
    func setViews(with movie: Movie)
    func setRightBarButton(with isLiked: Bool)
}

final class MovieDetailPresenter {
    private weak var viewControoler: MovieDetailProtocol?
    private let userDefaultManager: UserDefaultManegerProtocol
    private var movie: Movie
    init(
        viewcontroller: MovieDetailProtocol,
        movie: Movie,
        userDefaultManager: UserDefaultManegerProtocol = UserdefaultManager()
    ) {
        self.viewControoler = viewcontroller
        self.movie = movie
        self.userDefaultManager = userDefaultManager
    }
    
    func viewDidLoad() {
        viewControoler?.setViews(with: movie)
        viewControoler?.setRightBarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButtonTapped() {
        movie.isLiked.toggle()
        if !movie.isLiked {
            userDefaultManager.removeMovie(movie)
        } else {
            userDefaultManager.addMovies(movie)
        }

        viewControoler?.setRightBarButton(with: movie.isLiked)
    }
}
