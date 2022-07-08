//
//  ViewController.swift
//  RxCocoaPractice-01
//
//  Created by yangjs on 2022/07/06.
//

import UIKit
import SnapKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableview = UITableView(frame:.zero)
    let items = [1,2,3,4,5]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableview)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaInsets)
        }
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row])"
        return cell
    }
    

    
}

