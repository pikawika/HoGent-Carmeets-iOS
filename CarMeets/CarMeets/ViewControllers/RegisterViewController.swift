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
    
    func updateUI() {
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
        if ((emailTextView.text ?? "").isEmpty || (usernameTextView.text ?? "").isEmpty || (passwordTextView.text ?? "").isEmpty || (confirmPasswordTextView.text ?? "").isEmpty) {
            MessageUtil.showToast(message: "gelieve alle velden in te vullen", durationInSeconds: 1, controller: self)
        } else if (passwordTextView.text! != confirmPasswordTextView.text!) {
            MessageUtil.showToast(message: "wachtwoorden komen niet overeen", durationInSeconds: 1, controller: self)
        }
            
        else {
            //login request formaat maken
            let registerRequest = RegisterRequest.init(
                username: usernameTextView.text!,
                password: passwordTextView.text!,
                email: emailTextView.text!
            )
            
            //proberen inloggen met de userdata
            AccountController.shared.register(withAccountDetails: registerRequest) { (response) in
                DispatchQueue.main.async {
                    //login succes
                    if (response.0){
                        self.performSegue(withIdentifier: "registerToAccountSegue", sender: self)
                    } else {
                        MessageUtil.showToast(message: response.1, durationInSeconds: 1, controller: self)
                    }
                }
            }
        }
        
    }
    
    
}
