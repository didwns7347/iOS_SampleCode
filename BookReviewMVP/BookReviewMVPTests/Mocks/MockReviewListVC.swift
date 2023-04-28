//
//  MockReviewListVC.swift
//  BookReviewMVPTests
//
//  Created by yangjs on 2023/04/28.
//

import Foundation
@testable import BookReviewMVP
//원하는 타이밍에 메소드가 호출되는지 확인하는 뷰컨트롤러
final class MockReviewListViewController : ReviewListProtocol {
    var isCalledSetUpNavigationBar = false
    var isCalledSetUpViews = false
    var isCalledpresentReviewWriteVC = false
    var isCalledReloadTableView = false
    
    //true로바꼈으면 호출된것으로 테스트를 확인한다.
    func setUpNavigationBar() {
        isCalledSetUpNavigationBar = true
    }
    
    func setUpViews() {
        isCalledSetUpViews = true
    }
    
    func presentReviewWriteVC() {
        isCalledpresentReviewWriteVC = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    
    
}
