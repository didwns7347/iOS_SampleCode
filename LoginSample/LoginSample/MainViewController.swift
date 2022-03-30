//
//  MainViewController.swift
//  LoginSample
//
//  Created by yangjs on 2022/03/21.
//

import UIKit
import FirebaseAuth
import FirebaseAuth
class MainViewController:UIViewController{
    @IBOutlet weak var wellcomLabel: UILabel!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled=false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden=true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        wellcomLabel.text="""
                            환영합니다.
                            \(email)님
                          """
        let isMailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordBtn.isHidden = !isMailSignIn
    }
    @IBAction func resetPasswordBtnTapped(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email,completion: nil)
    }
    @IBAction func logoutBtnTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            print("ERROR: signout \(signOutError.description)")
        }
        
    }
}
