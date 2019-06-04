//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Luis Abraham on 2019-05-20.
//  Copyright © 2019 Luis Abraham. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayNavController = self.embedInNavigationController(UIViewController(), title: "Today", tabBarImageName: Images.todayIcon)
        
        let appsNavController = self.embedInNavigationController(AppsPageController(), title: "Apps", tabBarImageName: Images.appsIcon)
        
        let searchNavController = self.embedInNavigationController(AppsSearchController(), title: "Search", tabBarImageName: Images.searchIcon)
        
        self.viewControllers = [
            appsNavController,
            todayNavController,
            searchNavController
        ]
        
    }
    
    private func embedInNavigationController(_ rootViewController: UIViewController, title: String, tabBarImageName: String) -> UINavigationController {
        
        rootViewController.view.backgroundColor = .white
        rootViewController.navigationItem.title = title
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: tabBarImageName)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
