//
//  AddAlertViewController.swift
//  CH04localNotification
//
//  Created by yangjs on 2022/04/04.
//

import UIKit

class AddAlertViewController: UIViewController{
    @IBOutlet weak var datePicker: UIDatePicker!
    var pickedDate : ((_ date:Date)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissBtnAction(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true,completion: nil)
    }
}
