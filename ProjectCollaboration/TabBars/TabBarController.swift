//
//  TabBarController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var feedVC: FeedViewController = {
        let vc = FeedViewController()
        vc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "bubble.left"), tag: 0)
        return vc
    }()
    
    private lazy var postVC: CreatePostViewController = {
           let vc = CreatePostViewController()
        vc.tabBarItem = UITabBarItem(title: "Create Post", image: UIImage(systemName: "plus"), tag: 1)
           return vc
       }()
    
    private lazy var profileVC: ProfileViewController = {
           let vc = ProfileViewController()
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
           return vc
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: feedVC),          UINavigationController(rootViewController:postVC),     UINavigationController(rootViewController:profileVC)]
       
    }
    

}
