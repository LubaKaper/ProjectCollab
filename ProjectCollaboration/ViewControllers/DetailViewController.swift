//
//  DetailViewController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class DetailViewController: UIViewController {

   private var detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    private var selectedPost: Post
    private var professional: Professional
    
    init( _ selectedPost: Post, _ professional: Professional){
       
        self.selectedPost = selectedPost
        self.professional = professional
        super.init(nibName: nil, bundle: nil)

    }

    required init(coder: NSCoder) {
        fatalError("error")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        updateUI()
        buttonsPressed()
    }

    private func updateUI() {
        detailView.projectNameLabel.text = " Category: \(selectedPost.category) \n Project name: \(selectedPost.postTitle) \n Location: \n Start Date: \(selectedPost.startDate) \n Funds Needed: Not at this stage of the project "
        detailView.descriptionTextView.text = selectedPost.description
        detailView.postedByLabel.text = "posted by @\(selectedPost.postedBy)"
        detailView.postImageView.kf.setImage(with: URL(string: selectedPost.imageURL))

    }
    private func buttonsPressed() {
        detailView.allButtons[0].addTarget(self, action: #selector(collaborateButtonPressed(_:)), for: .touchUpInside)
        
        detailView.allButtons[1].addTarget(self, action: #selector(donateButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func collaborateButtonPressed(_ sender: UIButton) {
        print("collab button pressed")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        //TODO: Add closure with logic for firebase
        let collaboraterAction = UIAlertAction(title: "Collaborate on this project", style: .default) { (alertaction) in
            DatabaseServices.shared.addCollab(userName: self.professional.name) {[weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error collaborating", message: error.localizedDescription)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Success!" , message: "Now you ready to collaborate!")
                    }
                }
            }
        }
        alertController.addAction(collaboraterAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @objc func donateButtonPressed(_ sender: UIButton) {
        print("donate button pressed")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let paypalAction = UIAlertAction(title: "Donate with PayPal", style: .default) { [weak self](aletAction) in
            let url = "https://www.paypal.com/us/signin"
            let vc = SFSafariViewController(url: URL(string: url)!)
            self?.present(vc, animated: true)
        }
        alertController.addAction(paypalAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

}
