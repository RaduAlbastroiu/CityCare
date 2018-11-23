//
//  ImagePicker.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol ImagePickerManagerDelegate: class {
    func imageChosen(manager: ImagePickerManager, image: UIImage)
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imagePickerController = UIImagePickerController()
    private let presentingController: UIViewController
    
    weak var delegate: ImagePickerManagerDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingController = presentingViewController
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.cameraDevice = .rear
        }
        imagePickerController.mediaTypes = [kUTTypeImage as String]

        super.init()
        
        imagePickerController.delegate = self
    }
    
    func presentPhotoPickerCamera(animated: Bool) {
        presentingController.present(imagePickerController, animated: animated, completion: nil)
    }
    
    func dismissPhotoPicker(animated: Bool, completion: (() -> Void)?) {
        imagePickerController.dismiss(animated: animated, completion: completion)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        delegate?.imageChosen(manager: self, image: image)
    }
}
