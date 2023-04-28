//
//  ReviewListPresenter.swift
//  BookReviewMVP
//
//  Created by 양준수 on 2023/04/12.
//

import UIKit
import Kingfisher
protocol ReviewListProtocol {
    func setUpNavigationBar()
    func setUpViews()
    func presentReviewWriteVC()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject {
    
    private let vc: ReviewListProtocol
    private let bookStorageManager :UserDefaultsManagerProtocol
    private var reviews: [BookReview] = []
    init(
        vc : ReviewListProtocol,
        storageManager: UserDefaultsManagerProtocol = BookStorageManager()
    ){
        self.vc = vc
        bookStorageManager = storageManager
    }
    
    func viewDidLoad() {
        vc.setUpNavigationBar()
        vc.setUpViews()
    }
    
    func viewWillAppear() {
        vc.reloadTableView()
        fetchReviews()
        vc.reloadTableView()
        
    }
    
    func fetchReviews() {
        self.reviews = bookStorageManager.fetch()
        print(reviews)
    }
    
    func didRightBarButtonTapped() {
        vc.presentReviewWriteVC()
    }
}

extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let book = reviews[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.conent
        cell.imageView?.kf.setImage(with: book.thumbnail,completionHandler: { _ in
            cell.setNeedsLayout()
        })
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ReviewListPresenter : UITableViewDelegate {
    
}
