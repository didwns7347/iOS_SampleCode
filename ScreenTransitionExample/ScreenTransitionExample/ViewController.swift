//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by yangjs on 2022/02/16.
//

import UIKit

class ViewController: UIViewController ,sendDataDelegate{
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func codePushButtonTapped(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "codePushViewController") as? CodePushViewController else {return}
        viewController.name="진짜로"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func codePresentButtonTapped(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresntViewController") as? CodePresntViewController else{return}
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "지리게"
        viewController.delegate=self
        present(viewController, animated: true, completion: nil)
    }
    func sendData(name: String) {
        self.nameLabel.text=name
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? SeugePushViewController  else{return}
        viewController.name = "가보자잇"
        
    }
    
}

