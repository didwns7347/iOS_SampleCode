//
//  SeugePushViewController.swift
//  ScreenTransitionExample
//
//  Created by yangjs on 2022/02/16.
//

import UIKit

class SeugePushViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text=name
    }
    
    @IBAction func backButtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
