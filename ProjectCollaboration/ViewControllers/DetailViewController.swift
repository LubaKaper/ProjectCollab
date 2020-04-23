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
    private var professional = [Professional]()
    
    init( _ selectedPost: Post, _ professional: [Professional]){
        
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
        print("detail\(professional.first!.name)")
        navigationItem.title = "Together"
        addBackgroundGradient()
    }
    
    private func updateUI() {
        detailView.projectNameLabel.text = " Category: \(selectedPost.category) \n Project name: \(selectedPost.postTitle) \n Location: \(professional.first!.location) \n Start Date: \(selectedPost.startDate) \n Funds Needed: Not at this stage of the project "
        detailView.descriptionTextView.text = selectedPost.description
        detailView.postedByLabel.text = "posted by @\(selectedPost.postedBy)"
        detailView.postImageView.kf.setImage(with: URL(string: selectedPost.imageURL))
        
    }
    
    private func addBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.green.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
            DatabaseServices.shared.addCollab(userName: self.professional.first!.name, user: self.professional.last!) {[weak self] (result) in
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
        let donateAction = UIAlertAction(title: "Donate ", style: .default) { [weak self](aletAction) in
            let donateVC = DonationViewController()
            self?.navigationController?.pushViewController(donateVC, animated: true)
        }
        alertController.addAction(donateAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}
