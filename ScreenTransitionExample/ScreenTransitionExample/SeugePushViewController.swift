//
//  SeugePushViewController.swift
//  ScreenTransitionExample
//
//  Created by yangjs on 2022/02/16.
//

import UIKit

class SeugePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
