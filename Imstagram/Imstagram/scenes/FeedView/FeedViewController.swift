//
//  ViewController.swift
//  Imstagram
//
//  Created by yangjs on 2022/06/20.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
    
    private lazy var imagePickerController : UIImagePickerController = {
        let pickerView = UIImagePickerController()
        pickerView.sourceType = .photoLibrary
        pickerView.allowsEditing = true
        pickerView.delegate = self
        return pickerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigationBar()
        setupTableView()
    }

    @objc func uploadBtnTapped(){
        present(imagePickerController, animated: true)
        
        
    }
}

extension FeedViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FeedTableViewCell else{ return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}



extension FeedViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImg  : UIImage?
        if let editImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectImg = editImg
        }else if let originImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectImg = originImg
        }
        
        
        
        picker.dismiss(animated: true ){ [weak self] in
            let vc = PostViewCotnoller(img: selectImg ?? UIImage())
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController,animated: true)
        }
    }
}

private extension FeedViewController{
    func setUpNavigationBar(){
        self.navigationItem.title = "Instagram"
        let uploadBtn = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(uploadBtnTapped))
        self.navigationItem.rightBarButtonItem = uploadBtn
    }
    
    
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

