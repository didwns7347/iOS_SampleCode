//
//  SelectImagesCell.swift
//  UsedGoodsUpload
//
//  Created by yangjs on 2022/09/22.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import PhotosUI
import UIKit

class SelectImagesCell : UITableViewCell{
    let bag = DisposeBag()
    static let id = "SelectImage"
    var imageList : [NSItemProvider?] = [nil]
    var imageListSubject = BehaviorSubject<[NSItemProvider?]>(value: [nil])
    var selectImagesTapped = PublishSubject<PHPickerViewController>()
    
    private lazy var imagePicker : PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 5
        config.filter = .any(of: [.livePhotos, .images])
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        return pickerVC
    }()
    //private lazy var imgPicker : UIImagePickerController()
    
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
    
    func bind(viewModel : SelectImagesViewModel){
        viewModel.imageListDrive
            .drive(collectionView.rx.items(cellIdentifier: ItemImageCollectionViewCell.id, cellType: ItemImageCollectionViewCell.self)){ index, provider, cell in
                cell.configCell(provider: provider, row: index)
            }
            .disposed(by: bag)
         
        collectionView.rx.itemSelected
            .subscribe(onNext:{ indexPath in
                if indexPath.row == 0{
                    //self.present(self.imagePicker, animated: true)
                    self.selectImagesTapped.onNext(self.imagePicker)
                }
            }).disposed(by: bag)
        
        self.imageListSubject.subscribe { providers in
            viewModel.imageListSubject.on(providers)
        }.disposed(by: bag)
            
        self.selectImagesTapped.bind(to: viewModel.addImagesTapped)
            .disposed(by: bag)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension SelectImagesCell
{
    func attribute(){
   
//        self.picker.delegate = self
    }
    
    func layout(){
    
        [collectionView].forEach{
            self.contentView.addSubview($0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(110)
        }
    }
}

extension SelectImagesCell : UINavigationControllerDelegate, PHPickerViewControllerDelegate{
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        var providers :[NSItemProvider?] = results.map{$0.itemProvider}
        providers.insert(nil, at: 0)
        self.imageListSubject.onNext(providers)
   
    }
    
    
}

