//
//  SearchBookPresenter.swift
//  BookReviewMVP
//
//  Created by yangjs on 2023/04/27.
//

import Foundation
import UIKit
protocol SearchBookProtocol {
    func setUpViews()
    func dismiss()
    func reloadData()
}

protocol BookSearchDelegate {
    func bookDidSelected(book:Book)
}

final class SearchBookViewPresenter :NSObject{
    private let vc : SearchBookProtocol
    private let bookSearchManager = BookSearchManager()
    private var books : [Book] = []
    var bookSearckDelegate :BookSearchDelegate? = nil
    
    init(vc: SearchBookProtocol) {
        self.vc = vc
    }
    func viewDidload() {
        vc.setUpViews()
    }
    
}
extension SearchBookViewPresenter : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else {
            return
        }
        
        bookSearchManager.request(from: keyword) { [weak self] books in
            self?.books = books
            self?.vc.reloadData()
        }
    }
}
extension SearchBookViewPresenter : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var selectResult: [Book] = []
//        let selectedBook =  selectResult[indexPath.row]
        self.bookSearckDelegate?.bookDidSelected(book: self.books[indexPath.row])
        vc.dismiss()
    }
}
extension SearchBookViewPresenter : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row].title
        return cell
    }
    
    
}

