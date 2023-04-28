//
//  ReviewWriteViewController.swift
//  BookReviewMVP
//
//  Created by 양준수 on 2023/04/16.
//

import SnapKit
import Kingfisher
import UIKit
class ReviewWriteViewController : UIViewController{
    private lazy var presenter = ReviewWritePresenter(viewcontroller: self)
    
    
    
    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
    
    private lazy var titleButton : UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .bold)
        
        button.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
        return button
    }()
    

    
    private lazy var contentTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = "내용을 입력해주세요"
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.delegate = self
        return textView
        
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    
}

extension ReviewWriteViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else {
            return
        }
        textView.textColor = .label
        if textView.text == "내용을 입력해주세요"{
            textView.text = ""
        }
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol{
    func setUpNavigtaionBar(){
        let leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didLeftBarButtonTapped)
        )
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didRightBarButtonTapped)
        )
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    
    
    func showCloseAlertSheet() {
        let alertcontroller = UIAlertController(
            title: "닫을꺼냐?",
            message: nil,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "닫기", style: .destructive) {[weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertcontroller.addAction(okAction)
        alertcontroller.addAction(cancleAction)
        
        present(alertcontroller,animated: true)
    }
    
    func dismissVC(){
        self.dismiss(animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [titleButton, contentTextView, imageView]
            .forEach{ view.addSubview($0) }
        
        titleButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentTextView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleButton.snp.bottom).offset(16)
            
        }
        imageView.snp.makeConstraints{
            $0.leading.equalTo(contentTextView.snp.leading)
            $0.trailing.equalTo(contentTextView.snp.trailing)
            $0.top.equalTo(contentTextView.snp.bottom).offset(16)
            $0.height.equalTo(200.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func updateContent(title: String, iamgeURL:URL?) {
        self.titleButton.setTitle(title, for: .normal)
        self.titleButton.setTitleColor(.black, for: .normal)
//        self.contentTextView.text = title
        
        self.imageView.kf.setImage(with: iamgeURL)
    }
    
    func presentToSearchBookViewController() {
        let searchBookViewController = SearchBookViewController(delegate: presenter)
  
        let vc = UINavigationController(rootViewController: searchBookViewController)
        present(vc, animated: true)
    }
}
extension ReviewWriteViewController {
    @objc func didLeftBarButtonTapped(){
        presenter.didLeftBarButtonTapped()
    }
    
    @objc func didRightBarButtonTapped(){
        presenter.saveCurrentContent(current:contentTextView.text)
        presenter.didRightBarButtonTapped()
    }
    
    @objc func didTapBookTitleButton() {
        presenter.didTapBookTitleButton()
    }
}
