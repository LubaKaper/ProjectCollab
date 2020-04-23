//
//  ProfileViewController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    private var originalYConstraint: CGFloat?
    private var keyboardIsVisible = false
    private let db = Firestore.firestore()
    
    private var posts = [Post]()    {
        didSet {
            profileView.projectsPostedCollectionView.reloadData()
        }
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
      let ip = UIImagePickerController()
      ip.delegate = self
      return ip
    }()
    
    private var selectedImage: UIImage? {
      didSet {
        profileView.profilePictureImageView.image = selectedImage
      }
    }
    
    public lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()

    private let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        registerForKeyboardNotifications()
        profileView.bioTextView.delegate = self
        profileView.profileNameTextField.delegate = self
        profileView.expertiseTextField.delegate = self
        profileView.projectsPostedCollectionView.dataSource = self
        profileView.projectsPostedCollectionView.delegate = self
        // register cell here already in view?
        // implement cell
        profileView.profilePictureImageView.addGestureRecognizer(tapGesture)
        profileView.profilePictureImageView.isUserInteractionEnabled = true
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerForKeyboardNotifications()
        profileView.profilePictureImageView.isUserInteractionEnabled = true
    }
    
    private func updateUI()  {
        profileView.expertiseTextField.isUserInteractionEnabled = false
        profileView.profileNameTextField.isUserInteractionEnabled = false
        profileView.bioTextView.isUserInteractionEnabled = false
        
        DatabaseServices.shared.fetchAllPost { (result) in
            switch result    {
            case .failure(let error):
                print(error)
            case .success(let posts):
                self.posts = posts
            }
        }
        
        DatabaseServices.shared.fetchAllUsers { (result) in
            switch result    {
            case .failure(let error):
                print(error)
            case .success(let pros):
                self.profileView.profileNameTextField.text = pros[1].name
                self.profileView.expertiseTextField.text = pros[1].occupation
                self.profileView.bioTextView.text = pros[1].bio
            }
        }
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer)    {
        print("tap")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { alertAction in
          self.imagePickerController.sourceType = .camera
          self.present(self.imagePickerController, animated: true)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          alertController.addAction(cameraAction)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(photoLibraryAction)
        present(alertController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else  {
            return
        }
        print("keyboard frame is \(keyboardFrame)")
        moveKeyboardUp(keyboardFrame.size.height)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
    }
    
    private func moveKeyboardUp(_ height: CGFloat)   {
        if keyboardIsVisible { return }
        originalYConstraint = height
        profileView.bioTextView.frame.origin.y -= (height)
        
        UIView.animate(withDuration: 0.5)   {
            self.view.layoutIfNeeded()
        }
        
        keyboardIsVisible = true
    }
    
    private func resetUI()  {
        profileView.expertiseTextField.isHidden = false
        profileView.profileNameTextField.isHidden = false
        profileView.profilePictureImageView.isUserInteractionEnabled = true
        keyboardIsVisible = false
        profileView.bioTextView.frame.origin.y += (originalYConstraint ?? 0)
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension ProfileViewController: UITextFieldDelegate    {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        keyboardIsVisible = true
        return true
    }
}

extension ProfileViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        keyboardIsVisible = false
        profileView.expertiseTextField.isHidden = true
        profileView.profileNameTextField.isHidden = true
        profileView.profilePictureImageView.isUserInteractionEnabled = false
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray  {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty    {
            textView.text = "Bio"
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            textView.resignFirstResponder()
            resetUI()
            return false
        }
        return true
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      return
    }
    selectedImage = image
    dismiss(animated: true)
  }
}

extension ProfileViewController: UICollectionViewDataSource    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as? ProfileCell
            else    {
                fatalError()
        }
        
        let post = posts[indexPath.row]
        cell.configureCell(post: post)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout    {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
