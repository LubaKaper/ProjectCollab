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
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 13
    }
    
    public lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "cominc", size: 14)
        label.text = "Choose a category"
        return label
    }()
    
    public lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .systemBackground
        return pickerView
    }()
    
    public lazy var dateTextField: UILabel = {
        let textField = UILabel()
        textField.text = "Choose a start date"
        return textField
    }()
    
    public lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .systemBackground
        datePicker.datePickerMode = .date
        return datePicker
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
        confugureLabel()
        configurePickerView()
        configureDateTextField()
        configureDatePicker()
        configureButton()
    }
    
    private func confugureLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configurePickerView() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureDateTextField() {
        addSubview(dateTextField)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 12),
            dateTextField.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureDatePicker() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 8),
            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            datePicker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureButton() {
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 12),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
