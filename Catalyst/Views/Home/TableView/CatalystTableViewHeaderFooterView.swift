//
//  CatalystTableViewHeaderFooterView.swift
//  Catalyst
//
//  Created by Sathya on 03/03/23.
//

import UIKit

class CatalystTableViewHeaderFooterView: UITableViewHeaderFooterView {

    static let identifier = "CatalystTableViewHeaderFooterView"
    var delegate: SectionButtonDelegate?

    lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .secondaryLabel
        title.font = .systemFont(ofSize: 15, weight: .medium)
        return title
    }()

    private var isButtonSelected: Bool = false {
        didSet {
            if isButtonSelected {
                button.setImage(selectedButtonImage, for: .normal)
                button.tintColor = .systemBlue
            } else {
                button.setImage(unselectedButtonImage, for: .normal)
                button.tintColor = .tertiaryLabel
            }
        }
    }
    private let selectedButtonImage = UIImage(systemName: "checkmark.circle.fill")
    private let unselectedButtonImage = UIImage(systemName: "circle")

    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(unselectedButtonImage, for: .normal)
        button.addTarget(self, action: #selector(buttonOnClick), for: .touchDown)
        button.tintColor = .tertiaryLabel
        button.alpha = 0
        button.isUserInteractionEnabled = false
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButtonDefaults(section: Int) {
        let isButtonSelected = delegate?.isButtonSelectedByDefault?(for: section)
        guard let isButtonSelected = isButtonSelected else {
            return
        }
        self.isButtonSelected = isButtonSelected
    }

    func configureView(sectionName: String, section: Int) {
        title.text = sectionName
        button.tag = section

        configureButtonDefaults(section: section)
        contentView.addSubview(title)
        contentView.addSubview(button)

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor, multiplier: 0.80),
            title.heightAnchor.constraint(equalToConstant: 15),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo:contentView.layoutMarginsGuide.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @objc func buttonOnClick() {
        if isButtonSelected {
            self.isButtonSelected = false
            delegate?.buttonDeselected?(for: button.tag)
        } else {
            self.isButtonSelected = true
            delegate?.buttonSelected?(for: button.tag)
        }
    }
}
