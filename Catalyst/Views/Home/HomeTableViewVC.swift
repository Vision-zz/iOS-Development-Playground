    //
    //  HomeViewController.swift
    //  BreakingStuff
    //
    //  Created by Sathya on 21/02/23.
    //

import UIKit

class HomeTableViewVC: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "HomeViewTableCells")
        table.separatorStyle = .none
        table.allowsSelectionDuringEditing = true
        table.allowsMultipleSelectionDuringEditing = true
        table.backgroundColor = .clear
        return table
    }()

    struct CellData {
        typealias ControllersData = [(name: String, controller: UIViewController.Type, display: Bool)]
        let sectionName: String
        var controllers: ControllersData
        init(_ sectionName: String, controllers: ControllersData) {
            self.sectionName = sectionName
            self.controllers = controllers
        }
    }

    var subViewControllers: [CellData] = [
        CellData("Content Views", controllers: [
            ("Activity Indicator View", ActivityIndicatorViewVC.self, true),
            ("Calendar View", CalendarViewVC.self, false),
            ("Image View", ImageViewVC.self, true),
        ]),
    ]

    var tableDataSource: [CellData] {
        get {
            if tableView.isEditing {
                return subViewControllers
            }
            var cellData = [CellData]()
            subViewControllers.forEach({
                cellData.append(CellData($0.sectionName, controllers: $0.controllers.filter({ $0.display })))
            })
            return cellData
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.title = "Table View"
        
        view.addSubview(tableView)
        configureRightNavbarButton()
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self

    }

    func configureRightNavbarButton() {
        let barButton = UIBarButtonItem()
        barButton.title = "Edit"
        barButton.style = .plain
        barButton.target = self
        barButton.action = #selector(rightButtonOnClick)
        navigationItem.rightBarButtonItem = barButton
    }

    @objc func rightButtonOnClick() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        tableView.reloadSections(IndexSet(integersIn: 0..<tableDataSource.count), with: .automatic)
        if tableView.isEditing {
            for i in subViewControllers.indices {
                let controllers = subViewControllers[i].controllers
                for j in controllers.indices {
                    if controllers[j].display {
                        tableView.selectRow(at: IndexPath(row: j, section: i), animated: true, scrollPosition: .none)
                    }
                }
            }
        }
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }

}

extension HomeTableViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableCells", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.showsReorderControl = true
        var config = cell.defaultContentConfiguration()
        config.text = tableDataSource[indexPath.section].controllers[indexPath.row].name
        cell.contentConfiguration = config
        cell.backgroundColor = .clear
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        subViewControllers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableDataSource[section].controllers.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableDataSource[section].sectionName
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            subViewControllers[indexPath.section].controllers[indexPath.row].display = true
        } else {
            if tableView.indexPathForSelectedRow == indexPath {
                tableView.deselectRow(at: indexPath, animated: true)
            }
            let controller = tableDataSource[indexPath.section].controllers[indexPath.row].controller
            navigationController?.pushViewController(controller.init(), animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        subViewControllers[indexPath.section].controllers[indexPath.row].display = false
    }

    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        sourceIndexPath.section != proposedDestinationIndexPath.section ? sourceIndexPath : proposedDestinationIndexPath
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath == destinationIndexPath {
            return
        }
        let element = subViewControllers[sourceIndexPath.section].controllers.remove(at: sourceIndexPath.row)
        subViewControllers[sourceIndexPath.section].controllers.insert(element, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }

}
