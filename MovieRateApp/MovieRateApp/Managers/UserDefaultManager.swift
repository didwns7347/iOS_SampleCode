//
//  UserDefaultManager.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/28.
//

import Foundation

protocol UserDefaultManegerProtocol {
    func getMovies() -> [Movie]
    func addMovies( _ newValue: Movie)
    func removeMovie(_ value: Movie)
}
enum Key: String {
    case movie
}


struct UserdefaultManager: UserDefaultManegerProtocol {
 
    func getMovies() -> [Movie] {
        guard
            let data = UserDefaults.standard.data(forKey: Key.movie.rawValue)
        else { return [] }
        return (try? PropertyListDecoder().decode([Movie].self, from: data)) ?? []
    }
    
    func addMovies(_ newValue: Movie) {
        var currentMovies: [Movie] = getMovies()
        currentMovies.insert(newValue, at: 0)
        
        saveMovie(currentMovies)
    }
    
    func removeMovie(_ value: Movie) {
        let currentMovies: [Movie] = getMovies()
        let newValue = currentMovies.filter { movie in
            movie.title != value.title
        }
        
        saveMovie(newValue)
    }
    
    private func saveMovie(_ newValue: [Movie]) {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(newValue),
            forKey: Key.movie.rawValue
        )
    }
    
    
}
