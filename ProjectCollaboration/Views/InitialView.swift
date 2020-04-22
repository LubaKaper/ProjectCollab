//
//  InitialView.swift
//  ProjectCollaboration
//
//  Created by Tsering Lama on 4/22/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class InitialCreateView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pickerView.clipsToBounds = true
        pickerView.layer.cornerRadius = 13
        dateTextField.clipsToBounds = true
        dateTextField.layer.cornerRadius = 13
    }
    
    public lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .systemBackground
        return pickerView
    }()
    
    public lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "enter start date"
        return textField
    }()
    
    public lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configurePickerView()
        configureDateTextField()
        configureButton()
    }
    
    private func configurePickerView() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func configureDateTextField() {
        addSubview(dateTextField)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 8),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func configureButton() {
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 12),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    

    
    
    
}
