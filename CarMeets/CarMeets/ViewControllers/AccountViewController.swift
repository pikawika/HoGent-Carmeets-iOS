//
//  AccountViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    
    func updateUI() {
        //back button niet zichtbaar - login terug mag niet hier.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}
