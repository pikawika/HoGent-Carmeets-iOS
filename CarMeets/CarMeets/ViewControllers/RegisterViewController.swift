//
//  RegisterViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var loginLabel: LabelButton!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var usernameTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var confirmPasswordTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func registerClicked(_ sender: Any) {
    }
    
    func updateUI() {
        loginLabel.isUserInteractionEnabled = true
        loginLabel.onClick = {
            //ga terug naar login
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
    }
}
