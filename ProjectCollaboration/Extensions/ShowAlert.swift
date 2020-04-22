//
//  ShowAlert.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/21/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String?, message: String? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        
    }
}

