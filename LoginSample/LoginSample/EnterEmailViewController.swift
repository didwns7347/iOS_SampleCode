//
//  EnterEmailViewController.swift
//  LoginSample
//
//  Created by yangjs on 2022/03/18.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var viewNavigationBar: UINavigationItem!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMasageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 30
        loginBtn.isEnabled=false
        
        emailTextField.delegate=self
        passwordTextField.delegate=self
        //passwordTextField.dele
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        //FireBase 이메일 비밀번호 인증
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        //신규사용자 생성
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResutl, error in
            guard let self = self else {return}
            print("AuthResult = \(authResutl)")
            if let error = error{
                let code = (error as NSError).code
                switch code{
                case 17007://이미 가입된 계정
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMasageLabel.text = error.localizedDescription
                }
            }else{
                self.showMainViewController()
            }
        }
        
    }
    private func showMainViewController(){
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else {return}
            if let error = error{
                self.errorMasageLabel.text = error.localizedDescription
            }else{
                self.showMainViewController()
            }
        }
    }
    
}
extension EnterEmailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        self.loginBtn.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
    
}
