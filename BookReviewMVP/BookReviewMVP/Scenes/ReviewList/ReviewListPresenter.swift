//
//  ReviewListPresenter.swift
//  BookReviewMVP
//
//  Created by 양준수 on 2023/04/12.
//

import UIKit

protocol ReviewListProtocol {
    func setUpNavigationBar()
    func setUpViews()
    func presentReviewWriteVC()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject {
    
    private let vc: ReviewListProtocol
    
    init(vc : ReviewListProtocol){
        self.vc = vc
    }
    
    func viewDidLoad() {
        vc.setUpNavigationBar()
        vc.setUpViews()
    }
    
    func viewWillAppear() {
        vc.reloadTableView()
    }
    
    func didRightBarButtonTapped() {
        vc.presentReviewWriteVC()
    }
}

extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
}
