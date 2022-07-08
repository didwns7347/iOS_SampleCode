//
//  rxViewController.swift
//  RxCocoaPractice-01
//
//  Created by yangjs on 2022/07/06.
//

import UIKit
import RxCocoa
import RxSwift
class rxViewController: UIViewController {
    var tableview = UITableView(frame:.zero)
    let disoseBag = DisposeBag()
    let items = [1,2,3,4,5]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableview)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaInsets)
            
            
            let items = Observable.just((1...5).map{"\($0)"})
            
            items.bind(to: tableview.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){row,element,cell in
                cell.textLabel?.text = "\(element)"
            }
            
            tableview.rx
                .modelSelected(String.self)
                .subscribe(onNext:{print($0)})
                .disposed(by: disoseBag)
        }
    }
}

