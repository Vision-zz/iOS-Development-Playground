//
//  ResultsController.swift
//  Catalyst
//
//  Created by Sathya on 10/03/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class ResultsController: UICollectionViewController {
    var previousSearches = [String]()

    lazy var dataSource: [Country]! = nil

    lazy var countryNames: [Country] = []
    lazy var cityNames: [Country] = []
    lazy var languages: [Country] = []

    convenience init(dataSource: [Country]) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.dataSource = dataSource
    }

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        configureUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    func configureUI() {
        view.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = Util.createGlassMorphicEffectView(for: view.bounds)
    }
}

extension ResultsController {
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

     }
     */
}
