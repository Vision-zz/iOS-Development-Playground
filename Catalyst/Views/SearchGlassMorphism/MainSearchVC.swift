    //
    //  SearchVC.swift
    //  Catalyst
    //
    //  Created by Sathya on 07/03/23.
    //

import UIKit

class MainSearchVC: UIViewController {

    var rawData: [Country] = []

    lazy var dataSource: [Country] = rawData.sorted { $0.name < $1.name }

    lazy var countryTable: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MainSearchVCTableCell")
        table.separatorStyle = .none
        table.backgroundColor = Constants.UIBackgroundColor
        table.delegate = self
        table.dataSource = self
        table.keyboardDismissMode = .onDrag
        return table
    }()

    lazy var resultsController = ResultsController(dataSource: rawData)

    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: ResultsController(dataSource: rawData))
        search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        search.searchBar.placeholder = "Search country"
        search.searchBar.searchBarStyle = .prominent
        search.searchBar.delegate = self
        search.delegate = self
        search.searchBar.autocapitalizationType = .none
        search.hidesNavigationBarDuringPresentation = true
        search.searchBar.returnKeyType = .done
        search.showsSearchResultsController = true
        search.searchBar.showsSearchResultsButton = true
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        configureUI()
        configureConstraints()
    }

    func configureUI() {

        title = "Search"
        view.backgroundColor = Constants.UIBackgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(countryTable)

        let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonOnClick))
        searchBarButton.tintColor = .label

        let menuElement: [UIAction] = [
            UIAction(title: "Ascending", image: UIImage(systemName: "chevron.up.circle"), state: .on) { [weak self] _ in
                self?.dataSource = self?.dataSource.sorted(by: { $0.name < $1.name }) ?? []
                self?.countryTable.reloadData()
            },
            UIAction(title: "Descending", image: UIImage(systemName: "chevron.down.circle")){ [weak self] _ in
                self?.dataSource = self?.dataSource.sorted(by: { $0.name > $1.name }) ?? []
                self?.countryTable.reloadData()
            },
        ]

        let sortMenu = UIMenu(image: UIImage(systemName: "arrow.up.arrow.down"), identifier: nil, options: [.singleSelection], children: menuElement)

        let sortBarButton = UIBarButtonItem()
        sortBarButton.image = UIImage(systemName: "arrow.up.arrow.down")
        sortBarButton.tintColor = .label
        sortBarButton.menu = sortMenu

        navigationItem.rightBarButtonItems = [searchBarButton, sortBarButton]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    @objc func searchButtonOnClick() {
        searchController.searchBar.becomeFirstResponder()
    }

    @objc func sortButtonOnClick() {

    }

    func loadData() {
        let jsonUrlString = Bundle(for: type(of: self)).path(forResource: "Countries", ofType: "json")
        guard let jsonUrlString = jsonUrlString else { return }
        let jsonUrl = URL(fileURLWithPath: jsonUrlString)
        let jsonString = try? String(contentsOf: jsonUrl, encoding: .utf8)
        guard let jsonString = jsonString else { return }

        do {
            let arr = try JSONDecoder().decode([Country].self, from: Data(jsonString.utf8))
            self.rawData =  arr
        } catch {
            self.rawData = []
        }
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            countryTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countryTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            countryTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            countryTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}

extension MainSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainSearchVCTableCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = dataSource[indexPath.row].name
        config.secondaryText = dataSource[indexPath.row].capital
        config.secondaryTextProperties.color = .secondaryLabel
        cell.accessoryType = .detailButton
        cell.contentConfiguration = config
        cell.backgroundColor = Constants.UIBackgroundColor
        return cell
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        present(UINavigationController(rootViewController: CountryDetailsVC(data: dataSource[indexPath.row])), animated: true)
    }

}

extension MainSearchVC: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource = rawData
        countryTable.reloadData()
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Bookmark")
    }

}

