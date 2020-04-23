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
    
    public var date = Date()
    
    public var currentUser: Professional?
    
    private var originalYConstraint: CGFloat?
    private var keyboardIsVisible = false
    
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
        view.backgroundColor = .systemTeal
        configureNavigationBar()
        configureTextViews()
        addGestures()
    }
    
    private func configureTextViews() {
        createView.titleTextField.delegate = self
        createView.descriptionTextView.delegate = self
        createView.descriptionTextView.textColor = UIColor.lightGray
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
        navigationItem.title = category
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
    
    private func configureBar() {
        guard let titleLabel = createView.titleTextField.text,
            !titleLabel.isEmpty,
            let description = createView.descriptionTextView.text,
            !description.isEmpty,
            let image = createView.imageView.image,
            image == selectedImage
            else {
                navigationItem.rightBarButtonItem?.isEnabled = false
                return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    
    @objc private func addButtonPressed() {
        
        guard let titleLabel = createView.titleTextField.text,
            !titleLabel.isEmpty,
            let description = createView.descriptionTextView.text,
            !description.isEmpty,
            let selectedImage = selectedImage
            else {
                self.showAlert(title: "Missing Fields", message: nil)
                return
        }
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: createView.imageView.bounds)
        guard let currentUser = currentUser else {return}
        DatabaseServices.shared.createPost(title: titleLabel, date: date.string(with: "MMM dd, yyyy"), category: category, location: "", description: description, profId: currentUser.proId , postedBy: currentUser.name, collaborators: "", user: currentUser) { (result) in
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
                    self.resetUI()
                }
            }
        }
    }
    
    private func resetUI() {
        createView.imageView.image = UIImage(named: "photo")
        createView.titleTextField.text = ""
        createView.descriptionTextView.text = ""
    }
}

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("could not attain original image")
        }
        selectedImage = image
        dismiss(animated: true, completion: nil)
        navigationController?.navigationBar.isHidden = false
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

extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
extension CreatePostViewController: UITextFieldDelegate    {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        configureBar()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            configureBar()
            return false
        }
        return true
    }
}


