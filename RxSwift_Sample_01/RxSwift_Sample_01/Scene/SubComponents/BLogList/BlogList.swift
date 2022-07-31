//
//  BlogList.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/06.
//

import UIKit
import RxCocoa
import RxSwift

class BlogListView: UITableView{
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(frame: CGRect(
        origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 80)
    ))
    

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        attribute()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension BlogListView{
    func bind(_ viewModel:BlogListViewModel){
        viewModel.cellData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items){ tv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: "blogcell", for: index) as! BlogListCell
                cell.setData(data)
                return cell
            }.disposed(by: disposeBag )
    }
    
    func attribute(){
        self.backgroundColor = .white
        self.register(BlogListCell.self, forCellReuseIdentifier: "blogcell")
        self.separatorStyle = .singleLine
        self.rowHeight = 100
        self.tableHeaderView = headerView
    }
}
