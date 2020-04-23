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
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
        setupCollaboratorLabelConstraints()
    }
    
    private func setupCollaboratorLabelConstraints()    {
        addSubview(collaboratorLabel)
        
        collaboratorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collaboratorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            collaboratorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
