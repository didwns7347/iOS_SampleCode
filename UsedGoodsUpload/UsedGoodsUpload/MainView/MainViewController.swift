//
//  MainViewController.swift
//  UsedGoodsUpload
//
//  Created by yangjs on 2022/07/28.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import PhotosUI
class MainViewController : UIViewController{
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    var imageList : [NSItemProvider?] = [nil]
    var imageListSubject = BehaviorSubject<[NSItemProvider?]>(value: [nil])
    private lazy var imagePicker : PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 5
        config.filter = .any(of: [.livePhotos, .images])
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        return pickerVC
    }()
    private lazy var flowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.0
        layout.itemSize = CGSize(width: 70, height: 70)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(ItemImageCollectionViewCell.self, forCellWithReuseIdentifier: ItemImageCollectionViewCell.id)
        
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
        //bind(MainViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel:MainViewModel ){
        viewModel.cellData
            .drive(tableView.rx.items){ tv, row, data in
                switch row{
                case 0:
                    let cell = tv.dequeueReusableCell(withIdentifier: "TitleCell", for: IndexPath(row: row, section: 0)) as! TitleTextFieldCell
                    cell.selectionStyle = .none
                    cell.titleInputField.placeholder=data
                    cell.bind(vm: viewModel.titleTextFieldCellViewModel)
                    return cell
                case 1:
                    let cell = tv.dequeueReusableCell(withIdentifier: "categorySelectCell", for: IndexPath(row: 1, section: 0))
                    cell.selectionStyle = .none
                    cell.textLabel?.text = data
                    cell.accessoryType = .disclosureIndicator
                    return cell
                case 2:
                    let cell = tv.dequeueReusableCell(withIdentifier: "PriceTextFieldCell", for: IndexPath(row: row, section: 0)) as! PriceTextFieldCell
                    cell.selectionStyle = .none
                    cell.priceInputField.placeholder=data
                    cell.bind(viewModel.priceTextFieldCellViewModel)
                    return cell
                case 3:
                    let cell = tv.dequeueReusableCell(withIdentifier: "detailCell", for: IndexPath(row: row, section: 0)) as! DetailWriteFormCell
                    cell.selectionStyle = .none
                    cell.contentInputView.text=data
                    cell.bind(viewModel.detailWriteFormCellViewModel)
                    return cell
                default:
                    fatalError()

                }
                
            }.disposed(by: disposeBag)
        
        viewModel.presentAlert
            .emit(to: self.rx.setAlert)
            .disposed(by: disposeBag)
        
        viewModel.push
            .drive(onNext:{ viewModel in
                let vc = CategoryListViewController()
                vc.bind(viewModel)
                self.show(vc, sender: nil)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map{$0.row}
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind(to:viewModel.submitButtonTapped)
            .disposed(by: disposeBag)
        viewModel.imageListDrive
            .drive(collectionView.rx.items(cellIdentifier: ItemImageCollectionViewCell.id, cellType: ItemImageCollectionViewCell.self)){ index, provider, cell in
                cell.configCell(provider: provider, row: index)
            }
            .disposed(by: disposeBag)
         
        collectionView.rx.itemSelected
            .subscribe(onNext:{ indexPath in
                if indexPath.row == 0{
                    self.present(self.imagePicker, animated: true)
                }
            }).disposed(by: disposeBag)
        
        self.imageListSubject.subscribe { providers in
            viewModel.imageListSubject.on(providers)
        }.disposed(by: disposeBag)
            
    }
    
    private func attribute(){
        title = "중고거래 글쓰기"
        view.backgroundColor = .white
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleCell")
        //index row = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categorySelectCell")
        //index fow = 1
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")
        //index row = 2
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "detailCell")
    }
    
    private func layout(){
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
        }
        collectionView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(120)
        }
    }
}

typealias Alert = (title:String, message:String?)

extension Reactive where Base : MainViewController{
    var setAlert : Binder<Alert> {
        return Binder(base){ base , data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel)
            alertController.addAction(action)
            base.present(alertController, animated:true , completion: nil)
        }
    }
}
extension MainViewController : UINavigationControllerDelegate, PHPickerViewControllerDelegate{
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        var providers :[NSItemProvider?] = results.map{$0.itemProvider}
        providers.insert(nil, at: 0)
        self.imageListSubject.onNext(providers)
   
    }
    
    
}
