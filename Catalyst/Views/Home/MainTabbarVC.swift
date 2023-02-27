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

        let tableView = UINavigationController(rootViewController: HomeTableViewVC())
        let collectionView = UINavigationController(rootViewController: HomeCollectionViewVC())

        tableView.tabBarItem.image = UIImage(systemName: "list.bullet")
        tableView.title = "Table View"
        tableView.navigationBar.prefersLargeTitles = true

        collectionView.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        collectionView.title = "Collection View"
        collectionView.navigationBar.prefersLargeTitles = true

        tabBar.tintColor = .label
        tabBar.isTranslucent = true
        viewControllers = [tableView, collectionView]

        setViewControllers(viewControllers, animated: true)

    }

}
