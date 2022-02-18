//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by yangjs on 2022/02/17.
//

import UIKit

protocol LEDBoardSettingDelegate{
    func changedSetting(text: String?, textcolor:UIColor, backgroundColor:UIColor)
}
class SettingViewController: UIViewController {
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var orangeBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var purpleBtn: UIButton!
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var commentLabel: UITextField!
    
    var textColor :UIColor?
    var backgroundColor:UIColor?
    var LEDText:String?
    
    var delegete:LEDBoardSettingDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    private func configureView(){
        if let LEDText = self.LEDText {
            self.commentLabel.text=LEDText
        }
        if let backgroundColor = self.backgroundColor {
            self.changeBackgroundColorBtn(color: backgroundColor)
        }
        if let textColor = textColor {
            self.changeTextColor(color: textColor)
        }
        
    }
    @IBAction func tabSaveBtn(_ sender: UIButton) {
        self.delegete?.changedSetting(text: self.commentLabel.text, textcolor: self.textColor ?? .yellow , backgroundColor: self.backgroundColor ?? .black)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func tapTextColorBtn(_ sender: UIButton) {
        if sender == self.yellowBtn{
            self.changeTextColor(color: .yellow)
            self.textColor = .yellow
        }else if sender == self.purpleBtn{
            self.changeTextColor(color: .purple)
            self.textColor = .purple
        }else{
            self.changeTextColor(color: .green)
            self.textColor = .green
        }
    }

    @IBAction func tabBackgroundBtn(_ sender: UIButton) {
        if sender == self.blackBtn{
            self.changeBackgroundColorBtn(color: .black)
            self.backgroundColor = .black
        }else if sender == self.blueBtn{
            self.changeBackgroundColorBtn(color: .blue)
            self.backgroundColor = .blue
        }else{
            self.changeBackgroundColorBtn(color: .orange)
            self.backgroundColor = .orange
        }
    }
    private func changeTextColor(color:UIColor){
        self.yellowBtn.alpha = color==UIColor.yellow ? 1:0.2
        self.purpleBtn.alpha = color == UIColor.purple ? 1:0.2
        self.greenBtn.alpha = color == UIColor.green ? 1:0.2
    }
    
    private func changeBackgroundColorBtn(color: UIColor){
        self.blackBtn.alpha = color == UIColor.black ? 1:0.2
        self.blueBtn.alpha = color == UIColor.blue ? 1:0.2
        self.orangeBtn.alpha = color == UIColor.orange ? 1:0.2
    }
}
