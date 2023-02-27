//
//  HomeCollectionViewVC.swift
//  Catalyst
//
//  Created by Sathya on 24/02/23.
//

import UIKit

class HomeCollectionViewVC: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.setCollectionViewLayout(layout, animated: true)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.title = "Collection View"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(collectionView)
    }

}

extension HomeCollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        cell.backgroundColor = .red
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        return cell
    }

    
}
