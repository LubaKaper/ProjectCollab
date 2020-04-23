//
//  ProfileView.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    override func layoutSubviews() {
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.borderWidth = 3
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height / 2
        profilePictureImageView.layer.borderColor = UIColor.black.cgColor
        bioTextView.clipsToBounds = true
        bioTextView.layer.cornerRadius = 13
    }
    
    public lazy var projectsPostedCollectionView: UICollectionView =    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "profileCell")
        collectionView.backgroundColor = .systemOrange
        return collectionView
    }()
    
    private let backgroundImageView: UIImageView  =  {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.backgroundColor = .green
        return imageView
    }()
    
    public let profilePictureImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        imageView.image = UIImage(imageLiteralResourceName: "thanksgiving")
        imageView.contentMode = .scaleAspectFill
        imageView.layoutSubviews()
        return imageView
    }()
    
    public let profileNameTextField: UITextField =  {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    public let expertiseTextField: UITextField =  {
        let textField = UITextField()
        textField.placeholder = "Expertise"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    public let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Bio"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .lightGray
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
        setupBackgroundImageViewConstraints()
        setupProfilePictureImageView()
        setupProfileNameTextFieldConstraints()
        setupExpertiseTextFieldConstraints()
        setupBioTextViewConstraints()
        setupProjectPostedCollectionViewConstraints()
    }
    
    private func setupBackgroundImageViewConstraints()  {
        addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
    }
    
    private func setupProfilePictureImageView() {
        addSubview(profilePictureImageView)
        
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePictureImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            profilePictureImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            profilePictureImageView.heightAnchor.constraint(equalToConstant: 125),
            profilePictureImageView.widthAnchor.constraint(equalTo: profilePictureImageView.heightAnchor)

        ])
    }
    
    private func setupProfileNameTextFieldConstraints()    {
        addSubview(profileNameTextField)
        
        profileNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileNameTextField.topAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor, constant: 8),
            profileNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileNameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupExpertiseTextFieldConstraints()   {
        addSubview(expertiseTextField)
        
        expertiseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        expertiseTextField.topAnchor.constraint(equalTo: profileNameTextField.bottomAnchor, constant: 8),
        expertiseTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        expertiseTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupBioTextViewConstraints()  {
        addSubview(bioTextView)
        
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: expertiseTextField.bottomAnchor, constant: 11),
            bioTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bioTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bioTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bioTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func setupProjectPostedCollectionViewConstraints()   {
        addSubview(projectsPostedCollectionView)
        
        projectsPostedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            projectsPostedCollectionView.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 11),
            projectsPostedCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            projectsPostedCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            projectsPostedCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
}
