//
//  ProfileDataView.swift
//  Imstagram
//
//  Created by yangjs on 2022/06/22.
//

import UIKit
import SnapKit
final class ProfileDataView : UIView{
    private let title : String
    private let count : Int
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = title
        return label
    }()
    private lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "\(count)"
        return label
    }()
    
    init(title: String, count: Int) {
        self.title = title
        self.count = count
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


private extension ProfileDataView{
    func setupLayout(){
        let stackView = UIStackView(arrangedSubviews: [countLabel,titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
