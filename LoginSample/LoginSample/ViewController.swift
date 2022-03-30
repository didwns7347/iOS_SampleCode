//
//  ViewController.swift
//  LoginSample
//
//  Created by yangjs on 2022/03/18.
//

import UIKit
import GoogleSignIn
class ViewController: UIViewController {
   
    
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var googleBtn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        [emailBtn,appleBtn,googleBtn].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigation Bar 숨기기
        self.navigationController?.navigationBar.isHidden = true
        //Google Sign IN
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    
    @IBAction func googleLoginBtnTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func appleLoginBtnTapped(_ sender: Any) {
    }
    

}
