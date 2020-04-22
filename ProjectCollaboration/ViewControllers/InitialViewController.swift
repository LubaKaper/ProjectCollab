//
//  InitialViewController.swift
//  ProjectCollaboration
//
//  Created by Tsering Lama on 4/22/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class InitialCreatePostViewController: UIViewController {
    
    private var initialView = InitialCreateView()
    
    override func loadView() {
        view = initialView
    }
    
    let categories = ["Art", "Film", "iOS Development", "Gardening", "Health", "Other"]
    
    var selectedCategory: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureButton()
        initialView.pickerView.dataSource = self
        initialView.pickerView.delegate = self
    }
    
    private func configureButton() {
        initialView.submitButton.addTarget(self, action: #selector(sumbitButtonPressed), for: .touchUpInside)
    }
    
    @objc private func sumbitButtonPressed() {
        let postViewController = CreatePostViewController()
        postViewController.category = selectedCategory
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
