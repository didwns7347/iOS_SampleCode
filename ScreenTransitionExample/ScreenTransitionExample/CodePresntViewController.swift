//
//  CodePresntViewController.swift
//  ScreenTransitionExample
//
//  Created by yangjs on 2022/02/16.
//

import UIKit
protocol sendDataDelegate : AnyObject{
    func sendData(name:String)
}
class CodePresntViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name:String?
    weak var delegate :sendDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            self.nameLabel.text=name
        }

    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.delegate?.sendData(name: self.name ?? "")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
