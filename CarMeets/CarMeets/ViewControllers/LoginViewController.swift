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
    @IBOutlet weak var usernameTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
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
    
    @IBAction func loginClicked(_ sender: Any) {
        //checken of er veld leeg is
        if ((usernameTextView.text ?? "").isEmpty || (passwordTextView.text ?? "").isEmpty) {
            MessageUtil.showToast(message: "gelieve alle velden in te vullen", durationInSeconds: 1, controller: self)
        } else {
            //login request formaat maken
            let loginRequest = LoginRequest.init(username: usernameTextView.text!, password: passwordTextView.text!)
            
            //proberen inloggen met de userdata
            AccountController.shared.login(withCredentials: loginRequest) { (response) in
                //login succes
                if (response.0){
                    self.performSegue(withIdentifier: "loginToAccountSegue", sender: self)
                } else {
                    MessageUtil.showToast(message: response.1, durationInSeconds: 1, controller: self)
                }
            }
        }
        
    }
}



