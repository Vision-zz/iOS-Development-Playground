    //
    //  HomeViewController.swift
    //  BreakingStuff
    //
    //  Created by Sathya on 21/02/23.
    //

import UIKit

class HomeTableViewVC: UITableViewController {
    
    var rawData: [SectionData] = DataProvider.cellData

    var dataSource: [SectionData] = [] {
        didSet {
            dataSource.sort(by: { $0.sectionID < $1.sectionID })
            for i in 0..<dataSource.count {
                dataSource[i].controllers.sort(by: { $0.index < $1.index })
            }
        }
    }

    var sectionUpdates: [Int: Bool] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.title = "Table View"

        updateDataSourceFor(allElements: false)
        configureTableView()
        configureRightNavbarButton()
    }

    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeViewTableCells")
        tableView.register(CatalystTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CatalystTableViewHeaderFooterView.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
    }

    func configureRightNavbarButton() {
        let barButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(rightButtonOnClick))
        navigationItem.rightBarButtonItem = barButton
    }

    func updateDataSourceFor(allElements flag: Bool) {
        if flag {
            dataSource = rawData
            return
        }
        dataSource = []
        var displayableSections = rawData.filter({ $0.display })

//        displayableSections.forEach({ section in
//            section.controllers = section.controllers.filter({ $0.display })
//            dataSource.append(SectionData(section.sectionName, display: section.display, controllers: section.controllers.filter { $0.display }))
//        })

//        for section in displayableSections {
//            section.controllers = section.controllers.filter({ $0.display })
//        }

        for i in 0..<displayableSections.count {
            displayableSections[i].controllers = displayableSections[i].controllers.filter({ $0.display })
        }

        dataSource = displayableSections
    }

    @objc func rightButtonOnClick() {
        tableView.setEditing(!tableView.isEditing, animated: true)

        updateRowsAndSections(tableView.isEditing)

        updateSectionButtons(tableView.isEditing)
        if tableView.isEditing {
            for i in rawData.indices {
                let controllers = rawData[i].controllers
                for j in controllers.indices {
                    if controllers[j].display {
                        tableView.selectRow(at: IndexPath(row: j, section: i), animated: true, scrollPosition: .none)
                    }
                }
            }
        }
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }

    func updateRowsAndSections(_ isEditing: Bool) {
            updateSections(isEditing)
            updateRows(isEditing)
    }

    func updateRows(_ isEditing: Bool) {
        for i in 0..<dataSource.count {
            if isEditing {
                dataSource[i].controllers = rawData[i].controllers
            } else {
                dataSource[i].controllers = rawData[i].controllers.filter({ $0.display })
            }
        }

        var indexPaths = [IndexPath]()

        
        var sectionIndex = 0
        for section in 0..<rawData.count {
            guard rawData[section].display == true else {
                continue
            }
            let controller = rawData[section].controllers
            for row in 0..<controller.count {
                if(controller[row].display == false) {
                    indexPaths.append(IndexPath(row: row, section: isEditing ? section : sectionIndex))
                }
            }
            sectionIndex += 1
        }

        if indexPaths.count > 0 {
            isEditing ? tableView.insertRows(at: indexPaths, with: .left) : tableView.deleteRows(at: indexPaths, with: .left)
        }
    }

    func updateSections(_ isEditing: Bool) {
        if isEditing {
            for data in rawData {
                let contains = dataSource.contains(where: { $0.sectionID == data.sectionID })
                guard !contains else {
                    continue
                }
                dataSource.append(data)
            }
        } else {
            dataSource = dataSource.filter({ $0.display })
            dataSource.removeAll(where: { rawData[$0.sectionID].display == false })
        }
        var indexSet = IndexSet()
        for section in 0..<rawData.count {
            if rawData[section].display == false {
                indexSet.insert(section)
            }
        }

        if indexSet.count > 0 {
            isEditing ? tableView.insertSections(indexSet, with: .left) : tableView.deleteSections(indexSet, with: .left)
        }
    }

    func updateSectionButtons(_ isEditing: Bool) {

        for section in 0..<tableView.numberOfSections {
            let headerViewElements = tableView.headerView(forSection: section)?.contentView.subviews.filter({ $0 is UIButton })
            guard let headerViewElements = headerViewElements, headerViewElements.count > 0 else {
                return
            }
            let button = headerViewElements[0]

            if isEditing {
                UIView.animate(withDuration: 0.3, delay: 0, animations: { button.alpha = 1 })
                button.isUserInteractionEnabled = true
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, animations: { button.alpha = 0 })
                button.isUserInteractionEnabled = false
            }
        }
    }


}

extension HomeTableViewVC: SectionButtonDelegate {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableCells", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.showsReorderControl = true

        var config = cell.defaultContentConfiguration()
        let controller = dataSource[indexPath.section].controllers[indexPath.row]

        config.text =  controller.name
        config.image = controller.image
        config.imageProperties.tintColor = .label

        cell.contentConfiguration = config
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
//        tableView.isEditing ? rawData.count :
        dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableView.isEditing ? rawData[section].controllers.count :
        dataSource[section].controllers.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CatalystTableViewHeaderFooterView.identifier) as! CatalystTableViewHeaderFooterView
        view.delegate = self
        view.configureView(sectionName: dataSource[section].sectionName, section: section)
        return view
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            rawData[indexPath.section].controllers[indexPath.row].display = true
        } else {
            if tableView.indexPathForSelectedRow == indexPath {
                tableView.deselectRow(at: indexPath, animated: true)
            }
            let controller = dataSource[indexPath.section].controllers[indexPath.row].controller
            navigationController?.pushViewController(controller.init(), animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        rawData[indexPath.section].controllers[indexPath.row].display = false
    }

    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        sourceIndexPath.section != proposedDestinationIndexPath.section ? sourceIndexPath : proposedDestinationIndexPath
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath == destinationIndexPath {
            return
        }

        let sourceIndex = rawData[sourceIndexPath.section].controllers.firstIndex { $0.index == sourceIndexPath.row }
        let destinationIndex = rawData[destinationIndexPath.section].controllers.firstIndex { $0.index == destinationIndexPath.row }

        guard let sourceIndex = sourceIndex, let destinationIndex = destinationIndex else { return }

        let oldIndex = rawData[sourceIndexPath.section].controllers[sourceIndex].index
        let newIndex = rawData[destinationIndexPath.section].controllers[destinationIndex].index

        if newIndex < oldIndex {
            for i in 0..<rawData[sourceIndexPath.section].controllers.count {
                if rawData[sourceIndexPath.section].controllers[i].index >= newIndex && rawData[sourceIndexPath.section].controllers[i].index < oldIndex {
                    rawData[sourceIndexPath.section].controllers[i].index += 1
                }
            }
        } else if newIndex > oldIndex {
            for i in 0..<rawData[sourceIndexPath.section].controllers.count {
                if rawData[sourceIndexPath.section].controllers[i].index > oldIndex && rawData[sourceIndexPath.section].controllers[i].index <= newIndex {
                    rawData[sourceIndexPath.section].controllers[i].index -= 1
                }
            }
        }

        rawData[sourceIndexPath.section].controllers[sourceIndex].index = newIndex
        dataSource[sourceIndexPath.section].controllers = rawData[sourceIndexPath.section].controllers


    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .insert
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }

    func buttonSelected(for section: Int) {
//        sectionUpdates[section] = true
        rawData[section].display = true
    }

    func buttonDeselected(for section: Int) {
//        sectionUpdates[section] = false
        rawData[section].display = false
    }

    func isButtonSelectedByDefault(for section: Int) -> Bool {
        rawData[section].display
    }

}
