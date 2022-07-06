//
//  ViewController.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/01.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
}

private extension MainViewController{
    func bind(){
        
    }
    
    func attribute(){
        title = "다음 블로그 검색"
    }
    
    func layout(){
        
    }
    
}
