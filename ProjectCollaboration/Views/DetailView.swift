//
//  DetailView.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.clipsToBounds =  true
        postImageView.layer.cornerRadius = 13
        collaborateButton.clipsToBounds = true
        collaborateButton.layer.cornerRadius = 13
        donateButton.clipsToBounds = true
        donateButton.layer.cornerRadius = 13
        descriptionTextView.clipsToBounds = true
        descriptionTextView.layer.cornerRadius = 13
        projectNameLabel.clipsToBounds = true
        projectNameLabel.layer.cornerRadius = 13
    }
    
    public lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var projectNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.2375229895, green: 0.907618463, blue: 0.6326394081, alpha: 0.7408764983)
        label.text = "Category \nProject name \nLocation \nStart Date \n "
        label.textColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "ChalkboardSE-Regular", size: 18.0)
        return label
    }()
    
    public lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = " Here we will have the full description of the project that is being offere a collaboration on, with all the details "
        // textView.font = UIFont(name: "Didot", size: 20.0)
        textView.isSelectable = false
        textView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        textView.font = UIFont(name: "GillSans", size: 21.0)
        textView.textColor = .white
        return textView
    }()
    
    public lazy var postedByLabel: UILabel = {
        let label = UILabel()
        label.text = "postedBy@ "
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "GillSans", size: 20.0)
        label.textColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 0.6180436644)

        return label
    }()
    
    private lazy var collaborateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Collaborate", for: .normal)
        button.tag = 0
        button.backgroundColor = #colorLiteral(red: 0.2375229895, green: 0.907618463, blue: 0.6326394081, alpha: 0.7408764983)
        return button
    }()
    
    private lazy var donateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Donate", for: .normal)
        
        button.tag = 1
        button.backgroundColor = #colorLiteral(red: 0.2375229895, green: 0.907618463, blue: 0.6326394081, alpha: 0.7408764983)
        return button
    }()
    
    public lazy var allButtons: [UIButton] = {
        let buttons = [collaborateButton, donateButton]
        return buttons
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.axis = .horizontal
        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageViewConstraints()
        setupProjectInfoLabelConstraints()
        setupBostedbyLabelConstraints()
        setupDescriptionTextViewConstraint()
        setupStackViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            postImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35)
        ])
    }
    private func setupProjectInfoLabelConstraints() {
        addSubview(projectNameLabel)
        projectNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            projectNameLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
            projectNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            projectNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func setupBostedbyLabelConstraints() {
        addSubview(postedByLabel)
        postedByLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postedByLabel.topAnchor.constraint(equalTo: projectNameLabel.bottomAnchor, constant: 5),
            postedByLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            postedByLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func setupDescriptionTextViewConstraint() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: postedByLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupStackViewConstraints() {
        addSubview(stackView)
        stackView.addArrangedSubview(collaborateButton)
        stackView.addArrangedSubview(donateButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04)
        ])
    }
}
