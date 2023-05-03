//
//  ImagePicker.swift
//  Catalyst
//
//  Created by Sathya on 30/03/23.
//

import UIKit
import PhotosUI

class ImagePicker {

    typealias CompletionHandler = (UIImage?) -> Void

    private var completion: CompletionHandler? = nil

    lazy var config: PHPickerConfiguration = {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = PHPickerFilter.any(of: [.images, .screenshots, .depthEffectPhotos])
        config.preferredAssetRepresentationMode = .automatic
        config.selectionLimit = 1
        return config
    }()

    lazy var picker: PHPickerViewController = {
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        return picker
    }()

    func presentPicker(from viewController: UIViewController, handler: @escaping CompletionHandler) {
        self.completion = handler
        viewController.present(picker, animated: true)
    }
}

extension ImagePicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard !results.isEmpty, let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) else {
            completion?(nil)
            completion = nil
            return
        }

        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            self?.completion?(image as? UIImage)
            self?.completion = nil
        }
    }

}
