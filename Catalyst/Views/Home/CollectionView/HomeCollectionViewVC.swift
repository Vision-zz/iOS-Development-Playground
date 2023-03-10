    //
    //  HomeCollectionViewVC.swift
    //  Catalyst
    //
    //  Created by Sathya on 24/02/23.
    //

import UIKit

class HomeCollectionViewVC: UICollectionViewController {

    var subViewControllers: [SectionData] = DataProvider.cellData


    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }

    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.title = "Collection View"
        navigationController?.navigationBar.prefersLargeTitles = true

        configureCollectionView()
        configureConstraints()
        updateLayout()
    }

    func configureCollectionView() {
        collectionView.register(CatalystCollectionViewCell.self, forCellWithReuseIdentifier: CatalystCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
    }

    func updateLayout() {

        let provider: UICollectionViewCompositionalLayoutSectionProvider = { (section, environment) in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.30), heightDimension: .fractionalWidth(0.28))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.orthogonalScrollingBehavior = .continuous

            return section
        }

        let layout = UICollectionViewCompositionalLayout(sectionProvider: provider)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        collectionView.setCollectionViewLayout(layout, animated: true)

    }

    func configureConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}


extension HomeCollectionViewVC {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalystCollectionViewCell.identifier, for: indexPath) as! CatalystCollectionViewCell
        cell.data = subViewControllers[indexPath.section].controllers[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        subViewControllers[section].controllers.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = subViewControllers[indexPath.section].controllers[indexPath.row].controller
        navigationController?.pushViewController(controller.init(), animated: true)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        subViewControllers.count
    }
}
