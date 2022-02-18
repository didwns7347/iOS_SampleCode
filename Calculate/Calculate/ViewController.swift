//
//  ViewController.swift
//  Calculate
//
//  Created by yangjs on 2022/02/18.
//

import UIKit
enum Operation{
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknows
}
class ViewController: UIViewController {

    @IBOutlet weak var ouputLabel: UILabel!
    
    var displayNumber = ""
    var fisrtOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation :Operation = .unknows
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func tabDotBtn(_ sender: UIButton) {
        if self.displayNumber.count<8, !self.displayNumber.contains("."){
            self.displayNumber += self.displayNumber.isEmpty ? "0.":"."
            self.ouputLabel.text=displayNumber
        }
    }
    
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else{return}
        if self.displayNumber.count < 9{
            self.displayNumber += numberValue
            self.ouputLabel.text = self.displayNumber
        }
    }
    @IBAction func tabSubBtn(_ sender: Any) {
        self.operation(.Subtract)
    }
    
    @IBAction func tabEqualBtn(_ sender: Any) {
        self.operation(self.currentOperation)
    }
    @IBAction func tabAddBtn(_ sender: Any) {
        self.operation(.Add)
    }
    @IBAction func tabMultiplyBtn(_ sender: Any) {
        self.operation(.Multiply)
    }
    @IBAction func tabDivideBtn(_ sender: Any) {
        self.operation(.Divide)
    }
    @IBAction func clearButtnTapped(_ sender: UIButton) {
        self.displayNumber = ""
        self.fisrtOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknows
        self.ouputLabel.text = "0"
    }
    
    func operation(_ operation:Operation){
        if self.currentOperation != .unknows{
            if !self.displayNumber.isEmpty{
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                guard let firstOperand = Double(self.fisrtOperand) else{return}
                guard let secondOperand = Double(self.secondOperand) else{return}
                switch self.currentOperation{
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                default:
                    break
                }
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1)==0{
                    self.result = "\(Int(result))"
                }
                self.fisrtOperand = self.result
                self.ouputLabel.text = self.result
            }
            self.currentOperation = operation
            
            
        }else{
            self.fisrtOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
        
    }
}

