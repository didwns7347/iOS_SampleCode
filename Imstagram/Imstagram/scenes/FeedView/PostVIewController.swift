//
//  PostVIewController.swift
//  Imstagram
//
//  Created by yangjs on 2022/06/22.
//

import UIKit
import SnapKit

final class PostViewCotnoller :UIViewController{
    private let img:UIImage
    
    init(img:UIImage){
       
        self.img = img
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //private let img : UIImage
    private lazy var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = self.img
        return imgView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "문구 입력..."
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.delegate = self

        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayout()
    }
}
extension PostViewCotnoller: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }

        textView.text = nil
        textView.textColor = .label
    }
}

private extension PostViewCotnoller{
    func setupNavigation(){
        navigationItem.title = "새 게시물"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action:#selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "공유", style: .plain, target: self, action: nil)
    }
    @objc func cancelTapped(){
        self.dismiss(animated: true)
    }
    
    func setupLayout(){
        [imageView,textView].forEach{view.addSubview($0)}

        let imageViewInset: CGFloat = 16.0

        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(imageViewInset)
            $0.leading.equalToSuperview().inset(imageViewInset)
            $0.width.equalTo(100.0)
            $0.height.equalTo(imageView.snp.width)
        }

        textView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(imageViewInset)
            $0.trailing.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(imageView.snp.top)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
}
