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
}

final class SearchBookViewPresenter :NSObject{
    private let vc : SearchBookProtocol
    
    init(vc: SearchBookProtocol) {
        self.vc = vc
    }
    func viewDidload() {
        vc.setUpViews()
    }
    
}
extension SearchBookViewPresenter : UISearchBarDelegate {
    
}
extension SearchBookViewPresenter : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var selectResult: [Book] = []
//        let selectedBook =  selectResult[indexPath.row]
        vc.dismiss()
    }
}
extension SearchBookViewPresenter : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    
    
}

