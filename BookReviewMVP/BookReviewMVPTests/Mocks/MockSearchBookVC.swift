//
//  MockSearchBookVC.swift
//  BookReviewMVPTests
//
//  Created by yangjs on 2023/04/28.
//

import Foundation
@testable import BookReviewMVP
class MockSearchBookVC: SearchBookProtocol {
    var isCalledSetupViews = false
    var isCalledDismiss = false
    var isCalledreloadData = false
    
    func setUpViews() {
        <#code#>
    }
    
    func dismiss() {
        <#code#>
    }
    
    func reloadData() {
        <#code#>
    }
    
    
}
