//
//  RoundButton.swift
//  Calculate
//
//  Created by yangjs on 2022/02/18.
//

import UIKit
@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false{
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height/2
            }
        }
    }

}
