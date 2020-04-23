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
        image.image = UIImage(named: "photo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "ChalkboardSE-Light", size: 22)
        textField.placeholder = "Title goes here"
        return textField
    }()
    
    
    public lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.font = UIFont(name: "ChalkboardSE-Light", size: 22)
        textView.text = "Enter Description here"
        return textView
    }()
    
    public lazy var advanceLabel: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icons8-advance"), for: .normal)
        return button
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
    
    
    
    private func configureDescriptionTextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureButton() {
        addSubview(advanceLabel)
        advanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            advanceLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 14),
            advanceLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension UIButton {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.50
        shake.repeatCount = 24
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 24, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 24, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
}
