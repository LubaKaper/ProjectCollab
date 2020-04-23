//
//  DonationView.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/22/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class DonationView: UIView {
    
    public lazy var thankYouLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.2375229895, green: 0.907618463, blue: 0.6326394081, alpha: 0.7408764983)
        label.text = "Thank You For Donation! "
        label.textColor = #colorLiteral(red: 0.2367405891, green: 0.08727637678, blue: 0.6635397673, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "ChalkboardSE-Regular", size: 30.0)
        return label
    }()
    
    public lazy var thankYouImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "thankyouImage")
        imageView.contentMode = .scaleAspectFill
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
    
    private func commonInit() {
        setupLabelConstraints()
        setupImageViewConstraints()
        
    }
    
    private func setupLabelConstraints() {
        addSubview(thankYouLabel)
        thankYouLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thankYouLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            thankYouLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            thankYouLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            
        ])
    }
    private func setupImageViewConstraints() {
        addSubview(thankYouImageView)
        thankYouImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thankYouImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            thankYouImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            thankYouImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            thankYouImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
