//
//  ChangePasswordController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 20/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmedPasswordTextField: UITextField!
    
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        //checken of er veld leeg is
        if ((newPasswordTextField.text ?? "").isEmpty || (confirmedPasswordTextField.text ?? "").isEmpty) {
            MessageUtil.showToast(message: "Gelieve alle velden in te vullen", durationInSeconds: 1, controller: self)
            return
        }
        
        //checken of ww's gelijk
        if ((newPasswordTextField.text!) != (confirmedPasswordTextField.text!)) {
            MessageUtil.showToast(message: "Wachtwoorden komen niet overeen", durationInSeconds: 1, controller: self)
            return
        }
        
        
        //change password request formaat maken
        let changePasswordRequest = ChangePasswordRequest.init(newPassword: newPasswordTextField.text!)
        
        //proberen wachtwoord wijzigen met de request
        AccountController.shared.changePassword(withNewPasswordDetails: changePasswordRequest) { (response) in
            DispatchQueue.main.async {
                if (response.0){
                    MessageUtil.showToast(message: response.1, durationInSeconds: 1.0, controller: self) { () in
                        //ga terug naar account
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    }
                } else {
                    MessageUtil.showToast(message: response.1, durationInSeconds: 1, controller: self)
                }
            }
        }
    }
}
