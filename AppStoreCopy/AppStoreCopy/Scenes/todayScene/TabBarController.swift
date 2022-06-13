//
//  TabBarController.swift
//  AppStoreCopy
//
//  Created by yangjs on 2022/06/08.
//

import UIKit


class TabBarController: UITabBarController {

    private lazy var todayViewcontroller : UIViewController = {
        let vc = TodayViewContreoller()
        let tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "mail"), tag: 0)
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var appViewcontroller : UIViewController = {
        let vc = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up"), tag: 0)
        vc.tabBarItem = tabBarItem
        return vc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [todayViewcontroller,appViewcontroller]

    }


}

