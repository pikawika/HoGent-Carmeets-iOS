//
//  LoginViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var registerLabel: LabelButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        registerLabel.isUserInteractionEnabled = true
        registerLabel.onClick = {
            self.performSegue(withIdentifier: "loginToRegisterSegue", sender: self)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let loginRequest = LoginRequest.init(username: "snelleneddy", password: "test")
        
        //proberen inloggen met de userdata
        AccountController.shared.login(withCredentials: loginRequest) { (response) in
            //login succes
            if (response.0){
                self.performSegue(withIdentifier: "loginToAccountSegue", sender: self)
            } else {
                MessageUtil.showToast(message: response.1, durationInSeconds: 3, controller: self)
            }
            
        }
    }
}



