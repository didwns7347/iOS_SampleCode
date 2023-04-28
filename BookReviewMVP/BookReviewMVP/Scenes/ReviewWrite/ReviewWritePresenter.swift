//
//  ReviewWritePresenter.swift
//  BookReviewMVP
//
//  Created by 양준수 on 2023/04/16.
//

import Foundation
import UIKit

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
    let bookStorageManager: UserDefaultsManagerProtocol
    var book: Book? = nil
    let contentsTextViewPlaceHolderText = "내용을 입력해주세요."
    
    init(
        viewcontroller: ReviewWriteProtocol,
        reviewStorage : UserDefaultsManagerProtocol = BookStorageManager()
    ) {
        self.viewcontroller = viewcontroller
        self.bookStorageManager = reviewStorage
    }
    
    func viewDidLoad(){
        viewcontroller.setUpNavigtaionBar()
        viewcontroller.setupViews()
    }
    
   
    
    func didLeftBarButtonTapped() {
        viewcontroller.showCloseAlertSheet()
    }
    
    func didRightBarButtonTapped(contentText:String) {
        guard
            let book = book,
            contentText != contentsTextViewPlaceHolderText
        else {
            return
        }
        let bookModel = BookReview(title: book.title, conent: contentText, thumbnail: book.imageURL)
        
        bookStorageManager.save(book: bookModel)

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
        self.book = book
        updateView(book:book)
    }
    
    
}
