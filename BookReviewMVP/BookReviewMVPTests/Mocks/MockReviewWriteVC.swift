//
//  MockReviewWriteVC.swift
//  BookReviewMVPTests
//
//  Created by yangjs on 2023/04/28.
//

import Foundation
@testable import BookReviewMVP

class MockReviewWriteVC: ReviewWriteProtocol {
    var isCalledsetUpNavigtaionBar = false
    var isCalledshowCloseAlertSheet = false
    var isCalleddismissVC = false
    var isCalledsetupViews = false
    var isCalledpresentToSearchBookViewController = false
    var isCalledupdateContent = false
    
    func setUpNavigtaionBar() {
        isCalledsetUpNavigtaionBar = true
    }
    
    func showCloseAlertSheet() {
        isCalledshowCloseAlertSheet = true
    }
    
    func dismissVC() {
        isCalleddismissVC = true
    }
    
    func setupViews() {
        isCalledsetupViews = true
    }
    
    func presentToSearchBookViewController() {
        isCalledpresentToSearchBookViewController = true
    }
    
    func updateContent(title: String, iamgeURL: URL?) {
        isCalledupdateContent = true
    }
    
    
}
