    //
    //  ImagePickerVC.swift
    //  Catalyst
    //
    //  Created by Sathya on 22/02/23.
    //

import UIKit
import PhotosUI

class ImageViewVC: UIViewController {

    lazy var imagePicker: PHPickerViewController = {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = PHPickerFilter.any(of: [.images, .livePhotos, .videos])
        config.preferredAssetRepresentationMode = .automatic
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        return picker
    }()

    lazy var imagePickButton: UIButton = {
        var button = UIButton(type: .system)
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.title = "Pick Image"
        buttonConfiguration.image = UIImage(systemName: "hand.tap")
        buttonConfiguration.imagePadding = 5
        buttonConfiguration.baseBackgroundColor = .systemBlue
        button.configuration = buttonConfiguration
        button.layer.shadowRadius = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(imagePickButtonOnClick), for: .touchDown)
        button.tintColor = .label
        return button
    }()

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Image View"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(imagePickButton)
        view.addSubview(imageView)
        addConstraints()

    }

    @objc func imagePickButtonOnClick() {
        present(imagePicker, animated: true)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            imagePickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePickButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            imagePickButton.heightAnchor.constraint(equalToConstant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            imageView.widthAnchor.constraint(equalToConstant: 220),
            imageView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }

}

extension ImageViewVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        DispatchQueue.main.async {
            picker.dismiss(animated: true)
        }

        if results.count < 1 {
            return
        }
        guard let result = results.first else {
            return
        }
        guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else {
            return
        }

        result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { [weak self] (image, error) in
            if let image = image as? UIImage {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
                return
            }
        })

    }

}
