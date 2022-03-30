//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by yangjs on 2022/03/29.
//

import UIKit
import Lottie

class CardDetailViewConrtoller: UIViewController{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitContditionLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    
    @IBOutlet weak var lottieView: AnimationView!
    
    var promotionDetail: PromotionDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = AnimationView(name:"money")
        self.lottieView.contentMode = .scaleAspectFit
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = self.promotionDetail else {return}
        self.titleLabel.text = """
                                \(detail.companyName)카드 쓰면
                                \(detail.amount)만원 드려요
                                """
        self.periodLabel.text = detail.period
        self.conditionLabel.text = detail.condition
        self.benefitDetailLabel.text = detail.benefitDetail
        self.benefitDateLabel.text = detail.benefitDate
    }
    
    
    
}
