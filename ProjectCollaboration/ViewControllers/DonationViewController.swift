//
//  DonationViewController.swift
//  ProjectCollaboration
//
//  Created by Liubov Kaper  on 4/22/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {
    
    private var donationView = DonationView()
    
    override func loadView() {
        view = donationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2375229895, green: 0.907618463, blue: 0.6326394081, alpha: 0.7408764983)
        navigationItem.title = "Together"
       
    }
    

    

}
