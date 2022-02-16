//
//  ViewController.swift
//  AutolayoutExample
//
//  Created by yangjs on 2022/02/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var goodMent: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var byLabel: UILabel!
    let goodMents:[String]=["불가능 그건 하나의 의견일 뿐이다.|무하마드 알리",
                            "진인사대천명|제갈공명",
                            "어제보다 더 나은 내일은 토요일이다.|너덜트",
                            "가보자잇|노종호",
                            "진짜로? 지리게?|최대성",
                            "20대 사망률 1위 한라인만더|포브스",
                            "불편해? 불편하면 자세를 고쳐 앉아 자세가 잘못된거 아니에요|랄로",
                            "유연한 남탓, 사고하지 않기|랄로"
                            ]
    var quoteList=[Quote]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        goodMents.map{quoteList.append(Quote(contents: String($0.split(separator: "|")[0]), name: String($0.split(separator: "|")[1])))}
        // Do any additional setup after loading the view.
    }

    @IBAction func colorChangeButtonCliked(_ sender: UIButton) {
        self.colorView.backgroundColor=UIColor.cyan
        let num = Int.random(in: 0..<quoteList.count)
        self.goodMent.text = quoteList[num].contents
        self.byLabel.text = quoteList[num].name
        
    }
    
}

