//
//  DetailsVC.swift
//  Catalyst
//
//  Created by Sathya on 14/03/23.
//

import UIKit

class CountryDetailsVC: UITableViewController {

    lazy var data: Country! = nil

    convenience init(data: Country) {
        self.init(style: .insetGrouped)
        self.data = data
    }

    override init(style: UITableView.Style) {
        super.init(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = data.name
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DictCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ArrCell")
        tableView.allowsSelection = false
        tableView.backgroundColor = Constants.UIBackgroundColor
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        data.languages != nil ? 4 : 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 2
            case 1:
                return 3
            case 2:
                return data.languages?.count ?? data.timezones.count
            default:
                return data.timezones.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
            case 0:
                return " "
            case 2:
                return data.languages != nil ? "Languages" : "Timezones"
            case 3:
                return "Timezones"
            default:
                return nil
        }

    }

    func createDictCellView(key: String, value: String) -> UIView {
        let keyLabel = UILabel()
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        keyLabel.text = key
        keyLabel.textColor = .secondaryLabel
        keyLabel.font = .systemFont(ofSize: keyLabel.font.pointSize - 2, weight: .semibold)

        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.textColor = .label
        valueLabel.textAlignment = .right
        valueLabel.lineBreakMode = .byTruncatingTail

        let stackView = UIStackView(arrangedSubviews: [keyLabel, valueLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center

        NSLayoutConstraint.activate([
            keyLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),

            valueLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5),
            valueLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])

        return stackView
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.section < 2 ? "DictCell" : "ArrCell", for: indexPath)
        cell.backgroundColor = Constants.ContrastForeground
        if indexPath.section < 2 {
            var key: String, value: String
            switch (indexPath.section, indexPath.row) {
                case (0, 0):
                    key = "Country code"
                    value = data.code
                case (0, 1):
                    key = "Capital"
                    value = data.capital ?? "-"
                case (1, 0):
                    key = "Continent"
                    value = data.continent
                case (1, 1):
                    key = "Sub Region"
                    value = data.subregion ?? "-"
                case (1, 2):
                    key = "Area"
                    value = "\(data.area) ㎢"
                default:
                    key = ""
                    value = ""
            }
            let stackView = createDictCellView(key: key, value: value)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
                stackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                stackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
                stackView.heightAnchor.constraint(equalTo: cell.heightAnchor),
            ])
            return cell
        }

        else {
            var config = cell.defaultContentConfiguration()
            if indexPath.section == 3 {
                config.text = data.timezones[indexPath.row]
            } else {
                config.text = data.languages?[indexPath.row] ?? data.timezones[indexPath.row]
            }
            cell.contentConfiguration = config
            return cell
        }

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
