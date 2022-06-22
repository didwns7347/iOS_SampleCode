//
//  TabBarController.swift
//  Imstagram
//
//  Created by yangjs on 2022/06/20.
//

import Foundation
import UIKit
class TabBarController: UITabBarController{
    private lazy var feedVC :UIViewController = {
        let vc = UINavigationController(rootViewController: FeedViewController())
        let tabBarItem = UITabBarItem(title: "타임라인", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var  profileVC: UIViewController = {
        let vc = UINavigationController(rootViewController: ProfileViewController())
        let tabBarItem = UITabBarItem(title: "몰랑", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "Person.fill"))
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [feedVC,profileVC]
    }
    
}
