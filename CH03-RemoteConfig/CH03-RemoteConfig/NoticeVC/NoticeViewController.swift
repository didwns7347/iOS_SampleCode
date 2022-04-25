//
//  NoticeViewController.swift
//  CH03-RemoteConfig
//
//  Created by yangjs on 2022/03/31.
//

import UIKit

class NoticeViewController: UIViewController {
    var noticeContent : (title:String, detail:String, date:String)?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noticeView.layer.cornerRadius = 6
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        guard let noticeContent = noticeContent else {
            return
        }

        titleLabel.text=noticeContent.title
        detailLabel.text = noticeContent .detail
        dateLabel.text = noticeContent.date
    }

    @IBAction func doneBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
