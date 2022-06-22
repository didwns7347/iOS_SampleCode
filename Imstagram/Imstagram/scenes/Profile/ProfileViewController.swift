//
//  ProfileViewController.swift
//  Imstagram
//
//  Created by yangjs on 2022/06/21.
//

import UIKit

import SnapKit

final class ProfileViewController : UIViewController {
    private lazy var collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .systemBackground
        collectionview.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCell")
        collectionview.dataSource = self
        collectionview.delegate = self
        
        return collectionview
    }()
    
    private lazy var profileImg : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 40
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return imgView
    }()
    
    private lazy var nameLabel : UILabel = {
       let label = UILabel()
        label.text = "홍길동"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    private lazy var helloLabel : UILabel = {
       let label = UILabel()
        label.text = "안녕하세요"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var followBtn : UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.backgroundColor = .systemBlue

        button.layer.cornerRadius = 3.0
        return button
    }()
    
    private lazy var messageBtn : UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.backgroundColor = .white

        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        return button
    }()
    
    private let photoDataView = ProfileDataView(title: "게시물", count: 123)
    private let followerDataView = ProfileDataView(title: "팔로워", count: 23)
    private let followingDataView = ProfileDataView(title: "팔로윙", count: 2333)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
    }
}

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath)
        as? ProfileCollectionViewCell
        cell?.backgroundColor = .lightGray
        cell?.setUp(with: UIImage())
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width-32)/3 - 1
        return CGSize(width: size, height: size)
    }
}


private extension ProfileViewController{
    
    func setupNavigation(){
        navigationItem.title = "UserName"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(menuBtnTapped))
        
    }
    @objc func menuBtnTapped(){
        print("TAPPPED >..")
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let updateUserInfo = UIAlertAction(title: "회원정보 병경", style: .default)
        let deleteUser = UIAlertAction(title:"탈퇴하기", style: .destructive)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alertVC.addAction(updateUserInfo)
        alertVC.addAction(deleteUser)
        alertVC.addAction(cancel)
        present(alertVC,animated: true)
    }
    
    
    func setupView(){
        let sView = UIStackView( arrangedSubviews: [followBtn,messageBtn])
        sView.spacing = 4
        sView.distribution = .fillEqually
        
        let dataStackView = UIStackView(arrangedSubviews: [photoDataView,followerDataView,followingDataView])
        dataStackView.spacing=4
        dataStackView.distribution = .fillEqually
        
        [profileImg, nameLabel, helloLabel, sView,dataStackView,collectionView].forEach{view.addSubview($0)}
        
        let inset: CGFloat = 16.0
        
        profileImg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            make.leading.equalToSuperview().inset(inset)
            make.width.height.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImg.snp.bottom).offset(inset)
            make.leading.equalTo(profileImg.snp.leading)
            make.trailing.equalToSuperview().inset(inset)
        }
        
        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(inset)
            make.leading.equalTo(profileImg.snp.leading)
            make.trailing.equalToSuperview().inset(inset)
        }
        
        sView.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(inset)
            make.leading.equalTo(profileImg.snp.leading)
            make.trailing.equalToSuperview().inset(inset)
            //make.height.equalTo(50)
        }
        
        
        //view.addSubview(dataStackView)
        dataStackView.snp.makeConstraints{
            $0.leading.equalTo(profileImg.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.centerY.equalTo(profileImg.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sView.snp.bottom).offset(inset)
            make.leading.trailing.bottom.equalToSuperview().inset(inset)
        }
       
        
    }
}
