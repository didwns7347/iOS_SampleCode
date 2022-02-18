//
//  ViewController.swift
//  LEDBoard
//
//  Created by yangjs on 2022/02/17.
//

import UIKit


class ViewController: UIViewController , LEDBoardSettingDelegate{
    @IBOutlet var LEDView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentLabel.textColor = .yellow
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var viewController = segue.destination as? SettingViewController
        viewController?.delegete=self
        viewController?.LEDText=self.commentLabel.text
        viewController?.textColor = self.commentLabel.textColor
        viewController?.backgroundColor=self.LEDView.backgroundColor
    }
}

extension ViewController{
    func changedSetting(text: String?, textcolor: UIColor, backgroundColor: UIColor) {
        self.commentLabel.text = text
        self.commentLabel.textColor = textcolor
        self.LEDView.backgroundColor = backgroundColor
    }
}
