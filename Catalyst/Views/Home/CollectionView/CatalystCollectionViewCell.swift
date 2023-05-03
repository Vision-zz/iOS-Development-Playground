    //
    //  CatalystCollectionViewCell.swift
    //  Catalyst
    //
    //  Created by Sathya on 03/03/23.
    //

import UIKit

class CatalystCollectionViewCell: UICollectionViewCell {
    static let identifier = "CatalystCollectionViewCell"

    var data: RowData? {
        didSet {
            guard let data = data else { return }
            label.text = data.name
            imageView.image = data.image
        }
    }

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 12, weight: .medium))
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        activateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 3, right: 3))).cgPath
    }

    func configureCell() {
        self.backgroundColor = Constants.ContrastForeground
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.clear.cgColor

        self.layer.shadowColor = UIColor(hex: 0x020202).cgColor
        self.layer.shadowRadius = 7.5
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)

        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }

    func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
