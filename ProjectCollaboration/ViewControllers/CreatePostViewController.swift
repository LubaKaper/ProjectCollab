//
//  CreatePostViewController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseFirestore

class CreatePostViewController: UIViewController {
    
    private var createView = CreatePostView()
    
    public var category = ""
    
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
        createView.categoryTextField.text = category
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
        guard let titleLabel = createView.titleTextField.text,
            !titleLabel.isEmpty,
            let date = createView.dateTextField.text,
            !date.isEmpty,
            let location = createView.locationTextField.text,
            !location.isEmpty,
            let description = createView.descriptionTextView.text,
            !description.isEmpty,
            let selectedImage = selectedImage
            else {
                print("missing fields")
                return
        }
        
        
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: createView.imageView.bounds)
        
        DatabaseServices.shared.createPost(title: titleLabel, date: date, category: category, location: location, description: description, profId: "1", postedBy: "Oscar") { (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    print("error creating post \(appError)")
                }
            case .success(let documentId):
                DispatchQueue.main.async {
                    self.uploadPhoto(photo: resizedImage, documentId: documentId)
                }
            }
        }
    }
    
    private func uploadPhoto(photo: UIImage, documentId: String) {
        StorageService.shared.uploadPostPhoto(image: photo, postId: documentId) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let url):
                self.updateItemImageURL(url, documentsId: documentId)
            }
        }
        
    }
    
    private func updateItemImageURL(_ url: URL, documentsId: String) {
        
        Firestore.firestore().collection(DatabaseServices.postCollection).document(documentsId).updateData(["imageURL" : url.absoluteString]) { (error) in
            if let error = error {
                print("error \(error)")
            } else {
                print("succesfully updated image")
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
    
    private func hideKeyboard() {
        createView.dateTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillChnage(notification: Notification) {
        
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

extension UIImage {
    static func resizeImage(originalImage: UIImage, rect: CGRect) -> UIImage {
        let rect = AVMakeRect(aspectRatio: originalImage.size, insideRect: rect)
        let size = CGSize(width: rect.width, height: rect.height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            originalImage.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

