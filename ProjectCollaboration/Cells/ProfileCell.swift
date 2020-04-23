//
//  ProfileCell.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProfileCell: UICollectionViewCell {
    
    private lazy var collaboratorLabel: UILabel =   {
        let label = UILabel()
        label.text = "Collaborator: None"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var userNameLabel: UILabel =   {
        let label = UILabel()
        label.text = "Project Name"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var projectImageView: UIImageView  =   {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .systemGreen
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func configureCell(post: Post) {
        userNameLabel.text = post.postTitle
        projectImageView.getImage(with: post.imageURL) { (result) in
            switch result   {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                DispatchQueue.main.async {
                    self.projectImageView.image = data
                }
            }
        }
        collaboratorLabel.text = "Collaborator: \(post.collaborators)"
    }
    
    private func commonInit()   {
        setupProjectImageViewConstraints()
        setupProjectNameLabelConstraints()
        setupCollaboratorLabelConstraints()
    }
    
    private func setupProjectImageViewConstraints() {
        addSubview(projectImageView)
        
        projectImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            projectImageView.topAnchor.constraint(equalTo: topAnchor),
            projectImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            projectImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            projectImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        ])
    }
    
    private func setupProjectNameLabelConstraints() {
        addSubview(userNameLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            userNameLabel.topAnchor.constraint(equalTo: projectImageView.bottomAnchor, constant: 8)
        
        ])
    }
    
    private func setupCollaboratorLabelConstraints()    {
        addSubview(collaboratorLabel)
        
        collaboratorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collaboratorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collaboratorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collaboratorLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
        ])
    }
}
