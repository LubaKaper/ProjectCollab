//
//  CreatePostViewController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    private var createView = CreatePostView()
    
    override func loadView() {
        view = createView
    }
    
    private var selectedImage: UIImage? {
        didSet {
            createView.imageView.image = selectedImage
        }
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(showPhotoOptions))
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureNavigationBar()
        addGestures()
    }
    
    private func addGestures() {
        createView.imageView.isUserInteractionEnabled = true
        createView.imageView.addGestureRecognizer(longPressGesture)
     }
    
    func showAlert() {
        let alert = UIAlertController(title: "Success", message: "Your Project was succesfully uploaded", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    private func configureNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonPressed))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func showPhotoOptions() {
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { alertAction in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photoLibaray = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibaray)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
    @objc private func addButtonPressed() {
        showAlert()
    }
    
    
    
}

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("could not attain original image")
        }
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
}
