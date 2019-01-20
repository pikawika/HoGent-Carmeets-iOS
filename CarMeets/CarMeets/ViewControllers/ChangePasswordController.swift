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
        
        //proberen inloggen met de userdata
        AccountController.shared.changePassword(withNewPasswordDetails: changePasswordRequest) { (response) in
            DispatchQueue.main.async {
                MessageUtil.showToast(message: response.1, durationInSeconds: 1, controller: self)
                if (response.0){
                    //nog terug
                    
                }
            }
            
            
        }
    }
}
