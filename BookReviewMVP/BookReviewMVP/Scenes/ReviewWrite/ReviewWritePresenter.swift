//
//  ReviewWritePresenter.swift
//  BookReviewMVP
//
//  Created by 양준수 on 2023/04/16.
//

import Foundation

protocol ReviewWriteProtocol {
    func setUpNavigtaionBar()
    func showCloseAlertSheet()
    func dismissVC()
    func setupViews()
    func presentToSearchBookViewController()
    
    //view에서 model에 의존하지 않기 위해
    func updateContent(title: String, iamgeURL:URL?)
}

class ReviewWritePresenter {
    let viewcontroller: ReviewWriteProtocol
    
    init(viewcontroller: ReviewWriteProtocol) {
        self.viewcontroller = viewcontroller
    }
    
    func viewDidLoad(){
        viewcontroller.setUpNavigtaionBar()
        viewcontroller.setupViews()
    }
    
   
    
    func didLeftBarButtonTapped() {
        viewcontroller.showCloseAlertSheet()
    }
    
    func didRightBarButtonTapped() {
        viewcontroller.dismissVC()
    }
    
    func didTapBookTitleButton() {
        viewcontroller.presentToSearchBookViewController()
    }
    func updateView(book:Book) {
        viewcontroller.updateContent(title: book.title , iamgeURL:book.imageURL)
    }
    
}

extension ReviewWritePresenter : BookSearchDelegate {
    func bookDidSelected(book: Book) {
        updateView(book:book)
    }
    
    
}
