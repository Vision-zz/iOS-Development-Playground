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

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.UIBackgroundColor
        title = "Image View"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(imageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(buttonOnClick))
        addConstraints()

    }

    @objc func buttonOnClick() {
        present(imagePicker, animated: true)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
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
