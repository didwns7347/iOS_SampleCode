//
//  CodePushViewController.swift
//  ScreenTransitionExample
//
//  Created by yangjs on 2022/02/16.
//

import UIKit

class CodePushViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            self.nameLabel.text=name
        }
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
