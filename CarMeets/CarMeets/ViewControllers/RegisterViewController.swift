//
//  RegisterViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var loginLabel: LabelButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    private func updateUI() {
        loginLabel.isUserInteractionEnabled = true
        loginLabel.onClick = {
            //ga terug naar login
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        //checken of er veld leeg is
        if ((emailTextField.text ?? "").isEmpty || (usernameTextField.text ?? "").isEmpty || (passwordTextField.text ?? "").isEmpty || (confirmPasswordTextField.text ?? "").isEmpty) {
            
            MessageUtil.showToast(withMessage: "gelieve alle velden in te vullen", durationInSeconds: 1, controller: self)
            
            return
        }
        
        if (passwordTextField.text! != confirmPasswordTextField.text!) {
            
            MessageUtil.showToast(withMessage: "wachtwoorden komen niet overeen", durationInSeconds: 1, controller: self)
            
            return
            
        }
        
        
        //login request formaat maken
        let registerRequest = RegisterRequest.init(
            username: usernameTextField.text!,
            password: passwordTextField.text!,
            email: emailTextField.text!
        )
        
        //proberen inloggen met de userdata
        AccountController.shared.register(withAccountDetails: registerRequest) { (response) in
            DispatchQueue.main.async {
                //login succes
                if (response.0){
                    self.performSegue(withIdentifier: "registerToAccountSegue", sender: self)
                } else {
                    MessageUtil.showToast(withMessage: response.1, durationInSeconds: 1, controller: self)
                }
            }
            
        }
    }
}
