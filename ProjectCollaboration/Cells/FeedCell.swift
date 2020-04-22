//
//  FeedCell.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCell: UICollectionViewCell {
    
    public lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public lazy var postTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textColor = UIColor.blue
        label.text = "Article"
        return label
    }()
    
    public lazy var postedBy: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract"
        label.textColor = UIColor.blue
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.cornerRadius = 13
        postImage.layer.cornerRadius = 13
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImage()
        setupPostTitle()
        setupPostBy()
    }
    
    private func setupImage() {
        addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            postImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            postImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.80),
        ])
    }
    
    private func setupPostTitle() {
        addSubview(postTitle)
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            postTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupPostBy() {
        addSubview(postedBy)
        postedBy.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postedBy.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 8),
            postedBy.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postedBy.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    public func updateCell(post: Post) {
        postedBy.text = post.postedBy
        postTitle.text = post.postTitle
        postImage.kf.setImage(with: URL(string: post.imageURL))
    }
}


