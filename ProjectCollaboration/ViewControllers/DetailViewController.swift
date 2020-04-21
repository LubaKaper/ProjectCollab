//
//  DetailViewController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

   private var detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    private var selectedPost: Post
    
    init( _ selectedPost: Post){
       
        self.selectedPost = selectedPost
        super.init(nibName: nil, bundle: nil)

    }

    required init(coder: NSCoder) {
        fatalError("error")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        updateUI()
    }

    private func updateUI() {
        detailView.projectNameLabel.text = "Category: \(selectedPost.category) \nProject name: \(selectedPost.postTitle) \nLocation: \nStart Date: \(selectedPost.startDate) \n "
        detailView.descriptionTextView.text = selectedPost.description
        
        StorageService.shared.fetchPhoto(filename: "posts/\(selectedPost.imageURL)") { [weak self](result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let url):
                DispatchQueue.main.async {
                    self?.detailView.postImageView.kf.setImage(with: url)
                }
            }
        }
    }


}
