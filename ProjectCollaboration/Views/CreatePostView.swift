//
//  CreatePostView.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class CreatePostView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 13
        descriptionTextView.clipsToBounds = true
        descriptionTextView.layer.cornerRadius = 13
    }
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.fill")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "AmericanTypewriter", size: 17)
        textField.placeholder = "Title goes here"
        return textField
    }()
    
    
    public lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "AmericanTypewriter", size: 17)
        textField.placeholder = "New York, New York"
        return textField
    }()
    
    public lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.font = UIFont(name: "AmericanTypewriter", size: 17)
        textView.text = "This is where the description of the project will go. More information is needed in order for the user to post"
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configureImageViewConstraints()
        configureTitleTextField()
        configureLocationTextField()
        configureDescriptionTextView()
    }
    
    private func configureImageViewConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
            
        ])
    }
    
    private func configureTitleTextField() {
        addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func configureLocationTextField() {
        addSubview(locationTextField)
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            locationTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            locationTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureDescriptionTextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}



