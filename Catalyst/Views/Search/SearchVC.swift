    //
    //  SearchVC.swift
    //  Catalyst
    //
    //  Created by Sathya on 07/03/23.
    //

import UIKit

class SearchVC: UIViewController {

    lazy var countryTable: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SearchTableCell")
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "BackgroundColor")
        table.delegate = self
        table.dataSource = self
        table.keyboardDismissMode = .onDrag
        return table
    }()

    var rawData: [Country] = []

    lazy var dataSource: [Country] = rawData

    lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        search.searchBar.placeholder = "Search country"
        search.searchBar.searchBarStyle = .prominent
        search.searchBar.delegate = self
        search.delegate = self
        search.searchBar.autocapitalizationType = .none
        search.hidesNavigationBarDuringPresentation = true
        search.searchBar.returnKeyType = .done
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
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(countryTable)
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(buttonOnClick))
//        navigationItem.hidesSearchBarWhenScrolling = false
    }

    @objc func buttonOnClick() {
        searchController.searchBar.becomeFirstResponder()
    }

    func loadData() {
        let jsonUrlString = Bundle(for: type(of: self)).path(forResource: "Countries", ofType: "json")
        guard let jsonUrlString = jsonUrlString else { return }
        let jsonUrl = URL(fileURLWithPath: jsonUrlString)
        let jsonString = try? String(contentsOf: jsonUrl, encoding: .utf8)
        guard let jsonString = jsonString else { return }
        let arr = (try? JSONDecoder().decode([Country].self, from: Data(jsonString.utf8))) ?? []
        self.rawData = arr
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            //            searchController.searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            searchController.searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            //            searchController.searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            countryTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countryTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            countryTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            countryTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = dataSource[indexPath.row].name
        config.secondaryText = dataSource[indexPath.row].capital
        cell.contentConfiguration = config
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        return cell
    }



}

extension SearchVC: UISearchBarDelegate, UISearchControllerDelegate {

//    func presentSearchController(_ searchController: UISearchController) {
//        searchController.showsSearchResultsController = true
//
//    }



    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataSource = rawData
        } else {
            guard let regex = try? Regex(".*\(searchText.lowercased()).*") else { return }
            dataSource = rawData.filter({ country in
                let match = country.name.lowercased().firstMatch(of: regex)
                guard let _ = match else { return false }
                return true
            })
            dataSource += rawData.filter({ country in
                let match = country.capital.lowercased().firstMatch(of: regex)
                guard let _ = match else { return false }
                return true
            })
        }
        countryTable.reloadData()

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource = rawData
        countryTable.reloadData()
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Bookmark")
    }

}

