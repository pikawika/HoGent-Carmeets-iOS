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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var backButtonVisible = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (KeyChainUtil.isUserLoggedIn()) {
            self.performSegue(withIdentifier: "loginToAccountSegue", sender: self)
        }
        //back button al dan niet zichtbaar
        self.navigationItem.setHidesBackButton(!backButtonVisible, animated: false)
    }
    
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
        if ((usernameTextField.text ?? "").isEmpty || (passwordTextField.text ?? "").isEmpty) {
            MessageUtil.showToast(withMessage: "gelieve alle velden in te vullen", durationInSeconds: 1, controller: self)
        } else {
            //login request formaat maken
            let loginRequest = LoginRequest.init(username: usernameTextField.text!, password: passwordTextField.text!)
            
            //proberen inloggen met de userdata
            AccountController.shared.login(withCredentials: loginRequest) { (response) in
                //login succes
                DispatchQueue.main.async {
                    if (response.0){
                        //lijst refreshen voor user favourites
                        MeetingController.shared.fetchMeetings()
                        self.performSegue(withIdentifier: "loginToAccountSegue", sender: self)
                    } else {
                        MessageUtil.showToast(withMessage: response.1, durationInSeconds: 1, controller: self)
                    }
                }
                
            }
        }
        
    }
}



