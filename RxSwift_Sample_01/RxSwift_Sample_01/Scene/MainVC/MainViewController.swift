//
//  ViewController.swift
//  RxSwift_Sample_01
//
//  Created by yangjs on 2022/07/01.
//

import UIKit
import RxSwift
import RxCocoa
import CoreMIDI

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let searchBar = SearchBar()
    let listView = BlogListView()
    
    let alertActionTapped = PublishRelay<AlertAction>()
    
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
        let alertShhetForSorting = listView.headerView.sortButtonTapped
            .map{ element -> Alert in
                return (title:nil, message:nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        let blogResult = self.searchBar.shouldLoadResult
            .flatMapLatest { query in
                SearchBlogNetwork().searchBlog(query: query)
            }.share()
        
        let blogValue = blogResult
            .compactMap { data ->DKBlog? in
                guard case .success(let value) = data else{
                    return nil
                }
                return value
            }
        let blogError = blogResult
            .compactMap { data ->String? in
                guard case .failure(let error) = data else{
                    return nil
                }
                return error.localizedDescription
            }
        //네트워크를 통해 갸져온 값을 변환
        let cellData = blogValue
            .map { blog -> [BlogListCellData] in
                return blog.documents
                    .map{ doc in
                        let url = URL(string: doc.thumbnail ?? "")
                        let name = doc.name
                        let title = doc.title
                        let datetime = doc.datetime
                        return BlogListCellData(tumbnailURL: url, name: name, title: title, dateTime: datetime)
                    }
            }
        
        
        let sortedType = alertActionTapped
            .filter { action in
                switch action{
                case .title,.datetime:
                    return true
                default :
                    return false
                }
            }.startWith(.title)
        //LISTView 로 전달.
        Observable
            .combineLatest(sortedType,cellData){ type, data -> [BlogListCellData] in
                switch type{
                case .title:
                    return data.sorted{$0.title ?? "" < $1.title ?? ""}
                case .datetime:
                    return data.sorted{$0.dateTime ?? Date() > $1.dateTime ?? Date()}
                default :
                    return data
                }
            }.bind(to: listView.cellData).disposed(by: disposeBag)
        
        
        let alertForErrorMessage = blogError
            .map{ message -> MainViewController.Alert in
                return (
                    title: "오류",
                    message:"예상치 못한 오류 발생 \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        Observable
            .merge(alertShhetForSorting,alertForErrorMessage)
            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest{alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController,actions: alert.actions)
            }.emit(to: alertActionTapped)
            .disposed(by: disposeBag)
          
    }
            
        
   
    
    
    func attribute(){
        title = "다음 블로그 검색"
    }
    
    func layout(){
        [searchBar, listView].forEach{
            view.addSubview($0)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
extension MainViewController{
    typealias Alert = (title:String?, message:String?, actions:[AlertAction], style: UIAlertController.Style)
    
    enum AlertAction: AlertActionConvertible{
        case title, datetime, cancel
        case confirm
        
        var title:String{
            switch self{
            case .title:
                return "title"
            case .datetime:
                return "Datetime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style{
            switch self{
            case .title,.datetime:
                return .default
            case.cancel, .confirm:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action:AlertActionConvertible>(_ alertController: UIAlertController, actions:[Action])-> Signal<Action>{
        if actions.isEmpty{
            return .empty()
        }
        return Observable.create{ [weak self] observer in
            guard let self = self else{ return Disposables.create()}
            for action in actions{
                alertController.addAction(
                    UIAlertAction(title: action.title,
                                  style: action.style,
                                  handler: { _ in
                                      observer.onNext(action)
                                      observer.onCompleted()
                                  })
                    )
            }
            self.present(alertController, animated: true, completion: nil)
            return Disposables.create{
                alertController.dismiss(animated: true,completion: nil)
                    
            }
        }
        .asSignal(onErrorSignalWith: .empty())
    }
}
