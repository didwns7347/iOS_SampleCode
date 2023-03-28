//
//  MovieContentStackView.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/28.
//

import SnapKit
import UIKit

final class MovieContentsStackView: UIStackView {
    private let title: String
    private let content: String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = title
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = content
        return label
    }()
    
    init(title: String, contents: String) {
        self.title = title
        self.content = contents
        
        super.init(frame: .zero)
        
        self.axis = .horizontal
        
        [titleLabel, contentLabel]
            .forEach {
                self.addArrangedSubview($0)
            }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80.0)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
