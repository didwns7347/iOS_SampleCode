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
