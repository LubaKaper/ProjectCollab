//
//  InitialViewController.swift
//  ProjectCollaboration
//
//  Created by Tsering Lama on 4/22/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import FirebaseFirestore

class InitialCreatePostViewController: UIViewController {
    
    private var initialView = InitialCreateView()
    
    private var listener: ListenerRegistration?
    
    override func loadView() {
        view = initialView
    }
    
    var categories = ["Art", "Film", "iOS Development", "Gardening", "Health", "Other"]
    
    var selectedCategory: String!
    
    private var allUsers = [Professional]() {
        didSet {
            currentUser = allUsers.last
            print("initial\(currentUser!.name)")
        }
    }
    
    private var currentUser: Professional?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        listener = Firestore.firestore().collection(DatabaseServices.usersCollection).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                print("error getting users\(error.localizedDescription)")
            } else if let snapshot = snapshot {
                let currentUser = snapshot.documents.map {Professional($0.data())}
                self?.allUsers = currentUser
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(true)
         listener?.remove()
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureButton()
        initialView.pickerView.dataSource = self
        initialView.pickerView.delegate = self
        selectedCategory = categories.first
    }
    
    private func configureButton() {
        initialView.submitButton.addTarget(self, action: #selector(sumbitButtonPressed), for: .touchUpInside)
    }
    
    @objc private func sumbitButtonPressed() {
        let postViewController = CreatePostViewController()
        postViewController.currentUser = currentUser
        postViewController.category = selectedCategory
        postViewController.date = initialView.datePicker.date
        navigationController?.show(postViewController, sender: self)
    }

}

extension InitialCreatePostViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
}

extension InitialCreatePostViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        print(selectedCategory!)
    }
}
