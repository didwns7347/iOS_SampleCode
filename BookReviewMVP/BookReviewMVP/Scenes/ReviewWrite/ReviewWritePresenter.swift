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
}

class ReviewWritePresenter {
    let viewcontroller: ReviewWriteProtocol
    
    init(viewcontroller: ReviewWriteProtocol) {
        self.viewcontroller = viewcontroller
    }
    
    func viewDidLoad(){
        viewcontroller.setUpNavigtaionBar()
    }
    
   
    
    func didLeftBarButtonTapped() {
        viewcontroller.showCloseAlertSheet()
    }
    
    func didRightBarButtonTapped() {
        viewcontroller.dismissVC()
    }
    
}
