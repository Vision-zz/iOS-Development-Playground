    //
    //  SearchController.swift
    //  Catalyst
    //
    //  Created by Sathya on 10/03/23.
    //

import UIKit

class SearchDelegate: UISearchBarDelegate {


//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            dataSource = rawData
//        } else {
//            guard let regex = try? Regex(".*\(searchText.lowercased()).*") else { return }
//            dataSource = rawData.filter({ country in
//                let match = country.name.lowercased().firstMatch(of: regex)
//                guard let _ = match else { return false }
//                return true
//            })
//            dataSource += rawData.filter({ country in
//                let match = country.capital.lowercased().firstMatch(of: regex)
//                guard let _ = match else { return false }
//                return true
//            })
//        }
//        countryTable.reloadData()
//
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        dataSource = rawData
//        countryTable.reloadData()
//    }
}
