//
//  MainRouter.swift
//  1
//
//  Created by Роман Зобнин on 07.05.2021.
//

import Foundation
import UIKit

internal final class MainRouter {
    
    private let tabbar: UITabBarController
    private let couponsViewController: ViewController
    private let couponsNavController: UINavigationController
    
    internal init() {
        self.tabbar = UITabBarController()
        self.couponsViewController = ViewController()
        self.couponsNavController = UINavigationController(rootViewController: self.couponsViewController)
        self.configCouponsViewController()
        
        self.tabbar.setViewControllers([self.couponsViewController], animated: true)
    }
    internal func returnController() -> UITabBarController {
        return self.tabbar
    }
    
    internal func configCouponsViewController (){
        self.couponsViewController.view.backgroundColor = .blue
        let label = UILabel()
        label.text = "Купоны"
        self.couponsNavController.navigationBar.topItem?.titleView = label
        self.couponsNavController.tabBarItem.title = "Купоны"
    }
}
