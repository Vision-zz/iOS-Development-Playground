//
//  MainTabbarVC.swift
//  Catalyst
//
//  Created by Sathya on 27/02/23.
//

import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = true

        let tableViewNavController = UINavigationController(rootViewController: HomeTableViewVC())
        let collectionViewNavController = UINavigationController(rootViewController: HomeCollectionViewVC())

        tableViewNavController.tabBarItem.image = UIImage(systemName: "list.bullet")
        tableViewNavController.title = "Table View"
        tableViewNavController.navigationBar.prefersLargeTitles = true
        tableViewNavController.navigationBar.backgroundColor = UIColor(named: "BackgroundColor")

        collectionViewNavController.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        collectionViewNavController.title = "Collection View"
        collectionViewNavController.navigationBar.prefersLargeTitles = true
        collectionViewNavController.navigationBar.backgroundColor = UIColor(named: "BackgroundColor")

        tabBar.tintColor = .label
        tabBar.isTranslucent = true
        viewControllers = [tableViewNavController, collectionViewNavController]

        setViewControllers(viewControllers, animated: true)

    }

}
