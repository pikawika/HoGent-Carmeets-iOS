//
//  AccountViewController.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 18/01/2019.
//  Copyright © 2019 Lennert Bontinck. All rights reserved.

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //back button niet zichtbaar - login terug mag niet hier.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func changeUsernameClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Gebruikersnaam wijzigen", message: "Gelieve een nieuwe gebruikersnaam in te voeren", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Voer een nieuwe gebruikersnaam in"
        }
        
        let cancelAction = UIAlertAction(title: "Annuleer", style: .cancel)
        alert.addAction(cancelAction)
        
        let changeAction = UIAlertAction(title: "Wijzig", style: .default) { (alertAction) in
            let usernameTextfield = alert.textFields![0] as UITextField
            self.changeUsername(toNewUsername: usernameTextfield.text ?? "")
        }
        alert.addAction(changeAction)
        
        
        self.present(alert, animated: true)
    }
    
    @IBAction func signOutClicked(_ sender: Any) {
        KeyChainUtil.clearKeychain()
        //lijst refreshen voor user favourites weg te halen
        MeetingController.shared.fetchMeetings()
        //ga terug naar login
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    /**
     Zorgt er voor dat de UI met correcte gebruikersnaam uit token ingesteld wordt.
     */
    private func updateUI() {
        usernameLabel.text = TokenUtil.getUsernameFromToken()
    }
    
    /**
     Valideert nieuwe gebruikersnaam en probeert deze in te stellen op de server
     
     - Parameter toNewUsername: De nieuwe username dat de gebruiker wenst in te stellen.
     */
    private func changeUsername(toNewUsername username: String) {
        //checken of er veld leeg is
        if (username.isEmpty) {
            MessageUtil.showToast(withMessage: "Gelieve een gebruikersnaam mee te geven", durationInSeconds: 2, controller: self)
            return
        }
        
        
        //change username request formaat maken
        let changeUsernameRequest = ChangeUsernameRequest.init(newUsername: username)
        
        //proberen username wijzigen met de request
        AccountController.shared.changeUsername(withNewUsernameDetails: changeUsernameRequest) { (response) in
            DispatchQueue.main.async {
                if (response.0){
                    self.updateUI()
                }
                MessageUtil.showToast(withMessage: response.1, durationInSeconds: 1, controller: self)
                
            }
        }
    }
}
