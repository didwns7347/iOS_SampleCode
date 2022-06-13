//
//  AppViewController.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/09.
//

import UIKit
import SnapKit

final class AppViewController:UIViewController{
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeatureSectionView = RankingViewSection(frame: .zero)
        let exchangeCodeButtonView = CodeExchangeView(frame: .zero)
        
     
        
        [ featureSectionView,rankingFeatureSectionView,exchangeCodeButtonView ].forEach{
          
            //스텍 뷰에 뷰를 추가하기 위해서는 addArrangedSubview를 사용해야 한다.
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupLayout()
    }
    
}
private extension AppViewController{
    func setupNavigationController(){
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
