    //
    //  HomeViewController.swift
    //  BreakingStuff
    //
    //  Created by Sathya on 21/02/23.
    //

import UIKit

class HomeViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "HomeViewTableCells")
        table.separatorStyle = .none
        return table
    }()

    struct CellData {
        typealias ControllersData = [(name: String, controller: UIViewController.Type)]
        let sectionName: String
        var controllers: ControllersData
        init(_ sectionName: String, controllers: ControllersData) {
            self.sectionName = sectionName
            self.controllers = controllers
        }
    }

    lazy var subViewControllers: [CellData] = [
        CellData("Content Views", controllers: [
            ("Activity Indicator View", ActivityIndicatorViewVC.self),
            ("Calendar View", CalendarViewVC.self),
            ("Image View", ImageViewVC.self),
        ]),
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableCells", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.showsReorderControl = true
        var config = cell.defaultContentConfiguration()
        config.text = subViewControllers[indexPath.section].controllers[indexPath.row].name
        cell.contentConfiguration = config
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        subViewControllers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subViewControllers[section].controllers.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        subViewControllers[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let controller = subViewControllers[indexPath.section].controllers[indexPath.row].controller
        navigationController?.pushViewController(controller.init(), animated: true)
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
